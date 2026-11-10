# frozen_string_literal: true

# Conversational helper for weekly meal planning. Given what the household is
# in the mood for, Claude suggests recipes from the user's own active recipes,
# taking into account how recently each was made, servings, prep time, and the
# recipes already picked for this week (the "tray").
#
# The caller supplies the conversation `history` (see
# MealPlanAssistant::Conversation) and receives the updated history in the
# reply. Only text is kept in the history (no thinking blocks), so it never
# trips the API's preserved-thinking check.
#
# The "tray" is the meal plan for the upcoming prep day: the existing upcoming
# meal plan if there is one, otherwise MealPlan.suggested_date.
class MealPlanAssistant
  MODEL_ID = "claude-opus-5-5"
  EFFORT = "medium"
  MAX_TOKENS = 16_000
  REQUEST_TIMEOUT_SECONDS = 120
  # Refusal fallback: if a safety classifier declines, the API re-runs the
  # request on Anthropic's recommended fallback model instead of refusing.
  FALLBACK_BETA = "server-side-fallback-2026-07-01"

  MAX_HISTORY_MESSAGES = 40
  MAX_MESSAGE_LENGTH = 2_000
  MAX_STORED_MESSAGE_LENGTH = 20_000
  RECENT_MEAL_PLAN_COUNT = 8
  INGREDIENTS_PER_RECIPE = 12

  RESPONSE_SCHEMA = {
    type: "object",
    properties: {
      message: {type: "string"},
      suggestions: {
        type: "array",
        items: {
          type: "object",
          properties: {
            recipe_id: {type: "integer"},
            reason: {type: "string"}
          },
          required: %w[recipe_id reason],
          additionalProperties: false
        }
      }
    },
    required: %w[message suggestions],
    additionalProperties: false
  }.freeze

  INSTRUCTIONS = <<~PROMPT
    You help a household plan their weekly meal prep. On one prep day they cook several recipes to eat through the week. Your job is to make choosing those recipes fast and pleasant.

    You may only suggest recipes from their recipe box, listed below inside <recipe_box>. Never invent recipes, and always use the exact id shown.

    Each time they ask, suggest 5 or 6 recipes (fewer only if the request is narrow and few recipes genuinely fit). When choosing, weigh:
    - What they asked for. Interpret moods generously ("cozy" means warm, comforting dishes; "light" means fresh, not heavy).
    - How long since each recipe was last made. Favor recipes they haven't had in a while, and avoid recipes from the last couple of meal plans unless they ask for them.
    - Balance with the recipes already picked for this week: vary cuisines, main ingredients, and heavy versus light dishes.
    - Servings and total time, especially if they mention how many people they're feeding or how much time they have.

    Never suggest a recipe that is already picked for this week. Avoid repeating recipes you suggested earlier in this conversation unless they ask.

    Respond with JSON matching the provided schema:
    - "message": one to three friendly, plain-text sentences (no markdown). If the request is ambiguous, still make suggestions and ask one short follow-up question here. If nothing fits well, say so and offer the closest matches.
    - "suggestions": each with the recipe id and a "reason", one short sentence explaining why it fits. The reason appears under the recipe title on a card, so don't repeat the title. Be concrete (for example "Not made since August, and it covers the cozy request.").
  PROMPT

  class Error < StandardError; end

  Suggestion = Data.define(:recipe, :reason)
  Reply = Data.define(:message, :suggestions, :history)

  def self.reply(user:, message:, history: [], tray_recipe_ids: [], prep_day: nil)
    new(user, prep_day: prep_day).reply(message: message, history: history, tray_recipe_ids: tray_recipe_ids)
  end

  def self.prep_day_for(user)
    user.meal_plans.upcoming&.prepared_on || MealPlan.suggested_date(user)
  end

  def self.meal_plan_for(user, prep_day: prep_day_for(user))
    user.meal_plans.find_by(prepared_on: prep_day)
  end

  def initialize(user, prep_day: nil)
    @user = user
    @prep_day = prep_day || self.class.prep_day_for(user)
  end

  def reply(message:, history: [], tray_recipe_ids: [])
    message = message.to_s.strip.first(MAX_MESSAGE_LENGTH)
    raise Error, "Tell me what you're in the mood for." if message.blank?

    messages = sanitize_history(history) + [{role: "user", content: user_turn(message, tray_recipe_ids)}]
    response = request_reply(messages)
    text = response_text(response)
    parsed = JSON.parse(text)

    Reply.new(
      message: parsed["message"].to_s,
      suggestions: build_suggestions(parsed["suggestions"], excluded_ids: tray_recipe_ids),
      history: messages + [{role: "assistant", content: text}]
    )
  rescue JSON::ParserError, APIError, Net::ReadTimeout, Net::OpenTimeout, SocketError => e
    Rails.logger.error("MealPlanAssistant: #{e.class}: #{e.message}")
    raise Error, "Sorry, I couldn't come up with suggestions just now. Please try again."
  end

  private

  attr_reader :user, :prep_day

  def request_reply(messages)
    AnthropicApiClient.create_conversation(
      model: MODEL_ID,
      max_tokens: MAX_TOKENS,
      system: system_blocks,
      messages: messages,
      output_config: {effort: EFFORT, format: {type: "json_schema", schema: RESPONSE_SCHEMA}},
      fallbacks: "default",
      betas: [FALLBACK_BETA],
      timeout: REQUEST_TIMEOUT_SECONDS
    )
  end

  def response_text(response)
    case response["stop_reason"]
    when "refusal"
      raise Error, "Sorry, I can't help with that request. Try asking a different way."
    when "max_tokens"
      raise Error, "Sorry, that reply got cut off. Please try again."
    end

    text_block = Array(response["content"]).find { |block| block["type"] == "text" }
    raise JSON::ParserError, "no text block in response" if text_block.nil?

    text_block["text"]
  end

  # The instructions and recipe box come first and carry the cache breakpoint,
  # so follow-up turns in a session reuse the cached prefix. The date block is
  # after the breakpoint because it changes daily.
  def system_blocks
    [
      {type: "text", text: "#{INSTRUCTIONS}\n#{recipe_box}", cache_control: {type: "ephemeral"}},
      {type: "text", text: date_context}
    ]
  end

  def recipe_box
    <<~TEXT
      <recipe_box>
      #{active_recipes.map { |recipe| recipe_line(recipe) }.join("\n")}
      </recipe_box>

      <recent_meal_plans>
      #{recent_meal_plan_lines.presence || "No meal plans yet."}
      </recent_meal_plans>
    TEXT
  end

  def recipe_line(recipe)
    tags = recipe.tags.map(&:name).compact.sort
    ingredients = recipe.ingredients.map(&:name).reject(&:blank?).uniq.first(INGREDIENTS_PER_RECIPE)
    times_made = times_made_by_recipe_id.fetch(recipe.id, 0)
    last_made = recipe.last_prepared_on ? "last made #{recipe.last_prepared_on.iso8601}" : "never made"

    [
      "id #{recipe.id}",
      recipe.title,
      ("tags: #{tags.join(", ")}" if tags.any?),
      "serves #{recipe.servings}",
      "prep #{recipe.prep_time}m, cook #{recipe.cook_time}m",
      "#{last_made} (made #{times_made} #{"time".pluralize(times_made)})",
      ("ingredients: #{ingredients.join(", ")}" if ingredients.any?)
    ].compact.join(" | ")
  end

  def recent_meal_plan_lines
    user.meal_plans
      .where(prepared_on: ..Time.zone.today)
      .most_recent_first
      .includes(:recipes)
      .limit(RECENT_MEAL_PLAN_COUNT)
      .map { |plan| "#{plan.prepared_on.iso8601}: #{plan.recipes.map(&:title).sort.join(", ")}" }
      .join("\n")
  end

  def date_context
    today = Time.zone.today
    "Today is #{today.strftime("%A, %B %-d, %Y")}. They are planning for the prep day on #{prep_day.strftime("%A, %B %-d, %Y")}."
  end

  def user_turn(message, tray_recipe_ids)
    tray = active_recipes.select { |recipe| tray_recipe_ids.include?(recipe.id) }
    picked = if tray.any?
      tray.map { |recipe| "#{recipe.title} (id #{recipe.id}, serves #{recipe.servings})" }.join("; ")
    else
      "nothing yet"
    end

    "<picked_for_this_week>#{picked}</picked_for_this_week>\n\n#{message}"
  end

  def build_suggestions(raw_suggestions, excluded_ids:)
    recipes_by_id = active_recipes.index_by(&:id)

    Array(raw_suggestions)
      .uniq { |suggestion| suggestion["recipe_id"] }
      .filter_map do |suggestion|
        recipe = recipes_by_id[suggestion["recipe_id"]]
        next if recipe.nil? || excluded_ids.include?(recipe.id)

        Suggestion.new(recipe: recipe, reason: suggestion["reason"].to_s)
      end
  end

  # History comes back from the browser, so accept only well-formed
  # alternating text turns that start with the user, and cap their size.
  def sanitize_history(history)
    turns = Array(history).filter_map do |turn|
      turn = turn.to_h.stringify_keys
      next unless %w[user assistant].include?(turn["role"]) && turn["content"].is_a?(String)

      {role: turn["role"], content: turn["content"].first(MAX_STORED_MESSAGE_LENGTH)}
    end

    turns = turns.last(MAX_HISTORY_MESSAGES)
    turns = turns.drop_while { |turn| turn[:role] != "user" }
    return [] unless turns.each_cons(2).all? { |a, b| a[:role] != b[:role] } && turns.last&.dig(:role) != "user"

    turns
  end

  def active_recipes
    @active_recipes ||= user.recipes.active.includes(:tags, :ingredients).order(:id).to_a
  end

  def times_made_by_recipe_id
    @times_made_by_recipe_id ||= MealPlanRecipe
      .joins(:meal_plan)
      .where(meal_plans: {user_id: user.id})
      .group(:recipe_id)
      .count
  end
end
