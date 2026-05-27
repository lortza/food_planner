# frozen_string_literal: true

# Extracts structured recipe data from a Nokogiri doc.
#
# Strategy is tiered, cheapest-and-most-reliable first:
#   1. schema.org JSON-LD  (`<script type="application/ld+json">`)
#   2. schema.org Microdata (`itemprop` attributes)
#   3. Heuristic HTML scrape (headings + sibling lists)
#
# Each tier returns a normalized hash with the same shape, so callers
# never need to know which path produced the data:
#
#   {
#     title:       String,
#     servings:    Integer | nil,
#     prep_time:   Integer | nil,   # minutes
#     cook_time:   Integer | nil,   # minutes
#     total_time:  Integer | nil,   # minutes
#     image_url:   String  | nil,
#     ingredients: [String, ...],   # raw text lines
#     directions:  [String, ...],   # one entry per step
#     source:      :json_ld | :microdata | :heuristic | nil
#   }
#
# Ingredient text is NOT parsed into name/quantity/unit here — that's a
# separate concern (likely Claude). This class is responsible only for
# pulling reliable signal out of the page.
class RecipeDataExtractor2
  EMPTY_RESULT = {
    title: nil,
    servings: nil,
    prep_time: nil,
    cook_time: nil,
    total_time: nil,
    image_url: nil,
    ingredients: [],
    directions: [],
    source: nil
  }.freeze

  def initialize(doc)
    @doc = doc
  end

  class << self
    def extract_from_url(url)
      scraper = Scraper2.new(url)
      return EMPTY_RESULT.dup unless scraper.success?

      # Prefer the print-friendly page when available — less noise, more reliable.
      print_scraper = scraper.follow_print_url
      doc = print_scraper.success? ? print_scraper.doc : scraper.doc

      new(doc).extract
    end

    def extract_from_doc(doc)
      new(doc).extract
    end
  end

  def extract
    from_json_ld || from_microdata || from_heuristics || EMPTY_RESULT.dup
  end

  private

  # ---------- Tier 1: JSON-LD ----------

  def from_json_ld
    recipe_node = find_json_ld_recipe
    return nil unless recipe_node

    {
      title: string(recipe_node["name"]),
      servings: parse_servings(recipe_node["recipeYield"]),
      prep_time: iso8601_to_minutes(recipe_node["prepTime"]),
      cook_time: iso8601_to_minutes(recipe_node["cookTime"]),
      total_time: iso8601_to_minutes(recipe_node["totalTime"]),
      image_url: extract_image_url(recipe_node["image"]),
      ingredients: Array(recipe_node["recipeIngredient"]).map { |i| string(i) }.compact,
      directions: flatten_instructions(recipe_node["recipeInstructions"]),
      source: :json_ld
    }
  end

  def find_json_ld_recipe
    @doc.css('script[type="application/ld+json"]').each do |script|
      data = begin
        JSON.parse(script.text.to_s)
      rescue JSON::ParserError
        next
      end
      node = walk_for_recipe(data)
      return node if node
    end
    nil
  end

  # JSON-LD ships in wildly different shapes: a single object, an array of
  # objects, or wrapped under "@graph". Walk recursively to find @type=Recipe.
  def walk_for_recipe(node)
    case node
    when Array
      node.each do |n|
        found = walk_for_recipe(n)
        return found if found
      end
      nil
    when Hash
      return node if recipe_type?(node["@type"])
      node.values.each do |v|
        found = walk_for_recipe(v)
        return found if found
      end
      nil
    end
  end

  def recipe_type?(type)
    Array(type).any? { |t| t.to_s.casecmp("Recipe").zero? }
  end

  def flatten_instructions(value)
    Array(value).flat_map { |step| instruction_to_strings(step) }.compact.reject(&:blank?)
  end

  def instruction_to_strings(step)
    case step
    when String
      [step.strip]
    when Hash
      case step["@type"]
      when "HowToSection"
        flatten_instructions(step["itemListElement"])
      when "HowToStep"
        [string(step["text"])]
      else
        [string(step["text"] || step["name"])]
      end
    end
  end

  def extract_image_url(value)
    case value
    when String then value
    when Array then extract_image_url(value.first)
    when Hash then value["url"] || value["@id"]
    end
  end

  # ---------- Tier 2: Microdata ----------

  def from_microdata
    scope = @doc.at_css('[itemtype*="schema.org/Recipe"]')
    return nil unless scope

    {
      title: itemprop_text(scope, "name"),
      servings: parse_servings(itemprop_value(scope, "recipeYield")),
      prep_time: iso8601_to_minutes(itemprop_value(scope, "prepTime")),
      cook_time: iso8601_to_minutes(itemprop_value(scope, "cookTime")),
      total_time: iso8601_to_minutes(itemprop_value(scope, "totalTime")),
      image_url: itemprop_value(scope, "image"),
      ingredients: scope.css('[itemprop="recipeIngredient"], [itemprop="ingredients"]').map { |n| n.text.squish }.reject(&:blank?),
      directions: scope.css('[itemprop="recipeInstructions"]').map { |n| n.text.squish }.reject(&:blank?),
      source: :microdata
    }
  end

  def itemprop_text(scope, prop)
    node = scope.at_css(%([itemprop="#{prop}"]))
    node&.text&.squish.presence
  end

  # For props like image/url/time, the value is usually in an attribute
  # (content, datetime, src, href) rather than the element's text.
  def itemprop_value(scope, prop)
    node = scope.at_css(%([itemprop="#{prop}"]))
    return nil unless node
    (node["content"] || node["datetime"] || node["src"] || node["href"] || node.text).to_s.squish.presence
  end

  # ---------- Tier 3: Heuristic ----------

  def from_heuristics
    ingredients = ingredients_by_heading
    directions = directions_by_heading
    return nil if ingredients.empty? && directions.empty?

    {
      title: heuristic_title,
      servings: nil,
      prep_time: nil,
      cook_time: nil,
      total_time: nil,
      image_url: heuristic_image,
      ingredients: ingredients,
      directions: directions,
      source: :heuristic
    }
  end

  def heuristic_title
    (@doc.at_css("h1")&.text || @doc.at_css("title")&.text).to_s.squish.presence
  end

  def heuristic_image
    og = @doc.at_css('meta[property="og:image"]')
    og && og["content"].presence
  end

  def ingredients_by_heading
    list_items_following_heading(/ingredients?/i)
  end

  def directions_by_heading
    list_items_following_heading(/instructions?|directions?|method|steps?/i)
  end

  # Find a heading (h2/h3/h4) whose text matches `pattern`, then collect
  # the <li> text from the next sibling <ul>/<ol>. This is the most common
  # blog-recipe layout when no structured data exists.
  def list_items_following_heading(pattern)
    heading = @doc.css("h2, h3, h4").find { |h| h.text.to_s.strip.match?(pattern) }
    return [] unless heading

    list = heading.xpath("./following::ul[1] | ./following::ol[1]").first
    return [] unless list

    list.css("li").map { |li| li.text.squish }.reject(&:blank?)
  end

  # ---------- Shared helpers ----------

  # Converts ISO-8601 durations ("PT1H30M") into integer minutes.
  # Returns nil for blank/invalid input.
  def iso8601_to_minutes(value)
    return nil if value.blank?
    return value.to_i if value.is_a?(Numeric)

    str = value.to_s.strip
    return nil unless str.start_with?("PT", "P")

    hours = str[/(\d+)H/, 1].to_i
    minutes = str[/(\d+)M/, 1].to_i
    total = hours * 60 + minutes
    total.positive? ? total : nil
  end

  # Servings can show up as "4", "4 servings", "4-6", or { "@type": "QuantitativeValue", "value": 4 }.
  # Per existing convention, take the lower bound of a range.
  def parse_servings(value)
    case value
    when Numeric then value.to_i
    when Array then parse_servings(value.first)
    when Hash then parse_servings(value["value"] || value["minValue"])
    when String
      match = value.match(/\d+/)
      match && match[0].to_i
    end
  end

  def string(value)
    value.is_a?(String) ? value.squish.presence : nil
  end
end
