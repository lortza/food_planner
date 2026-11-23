# frozen_string_literal: true

class MealPlanAssistant
  # Keeps a user's planning chat in Rails.cache so leaving the page (opening a
  # recipe, going back, refreshing) doesn't lose it. Keyed by prep day, so each
  # week's planning starts fresh.
  #
  # Stores two things: `history`, the text-only API messages sent back to
  # Claude, and `turns`, what the page renders (her message, Claude's reply,
  # and suggested recipe ids with reasons).
  class Conversation
    EXPIRES_IN = 3.days
    CACHE_VERSION = 1

    Turn = Data.define(:user_message, :message, :suggestions)

    def initialize(user:, prep_day:)
      @user = user
      @prep_day = prep_day
    end

    def history
      data["history"]
    end

    def turns
      raw_turns = data["turns"]
      recipe_ids = raw_turns.flat_map { |turn| turn["suggestions"].map { |s| s["recipe_id"] } }
      recipes_by_id = user.recipes.active.where(id: recipe_ids).index_by(&:id)

      raw_turns.map do |turn|
        suggestions = turn["suggestions"].filter_map do |suggestion|
          recipe = recipes_by_id[suggestion["recipe_id"]]
          Suggestion.new(recipe: recipe, reason: suggestion["reason"]) if recipe
        end

        Turn.new(user_message: turn["user_message"], message: turn["message"], suggestions: suggestions)
      end
    end

    def append(user_message:, reply:)
      turn = {
        "user_message" => user_message,
        "message" => reply.message,
        "suggestions" => reply.suggestions.map { |s| {"recipe_id" => s.recipe.id, "reason" => s.reason} }
      }

      write(
        "history" => reply.history.map { |message| message.to_h.stringify_keys },
        "turns" => data["turns"] + [turn]
      )

      Turn.new(user_message: user_message, message: reply.message, suggestions: reply.suggestions)
    end

    def clear
      Rails.cache.delete(cache_key)
      @data = nil
    end

    private

    attr_reader :user, :prep_day

    def data
      @data ||= Rails.cache.read(cache_key) || {"history" => [], "turns" => []}
    end

    def write(new_data)
      Rails.cache.write(cache_key, new_data, expires_in: EXPIRES_IN)
      @data = new_data
    end

    def cache_key
      "meal_plan_assistant/v#{CACHE_VERSION}/user/#{user.id}/#{prep_day.iso8601}"
    end
  end
end
