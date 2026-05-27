# frozen_string_literal: true

class RecipeDataExtractor
  MAX_TOKENS = 8192
  FALLBACK_RESPONSE = {}

  class << self
    def extract(source_url:, provided_body: nil)
      return parse_with_llm(provided_body) if provided_body.present?

      scraper = Scraper.new(source_url)
      content = if scraper.print_url.present?
        print_scraper = Scraper.new(scraper.print_url)
        print_scraper.site_content
      elsif scraper.site_content.present?
        scraper.site_content
      else
        return FALLBACK_RESPONSE
      end

      content.present? ? parse_with_llm(content) : FALLBACK_RESPONSE
    end

    def build_recipe(recipe:, extracted_data:)
      recipe.source_name = URI.parse(recipe.source_url).host.gsub("www.", "")
      recipe.title = extracted_data["title"] if extracted_data["title"].present? && recipe.title.blank?
      recipe.instructions = extracted_data["ingredients_text"] + "\n\n" + extracted_data["instructions"] if extracted_data["instructions"].present? && extracted_data["ingredients_text"].present?
      recipe.servings = extracted_data["servings"] if extracted_data["servings"].present?
      recipe.prep_time = extracted_data["prep_time"] if extracted_data["prep_time"].present?
      recipe.cook_time = extracted_data["cook_time"] if extracted_data["cook_time"].present?
      recipe.image_url = extracted_data["image_url"] unless recipe.image_url.present?

      if extracted_data["ingredients"].present?
        extracted_data["ingredients"].each do |ingredient|
          if ingredient["name"].present? && ingredient["quantity"].present? && ingredient["measurement_unit"].present?
            recipe.ingredients.build(
              name: ingredient["name"],
              quantity: ingredient["quantity"],
              measurement_unit: ingredient["measurement_unit"],
              preparation_style: ingredient["preparation_style"]
            )
          end
        end
      end

      recipe
    end

    private

    def parse_with_llm(content)
      prompt_text = "Please extract the recipe from the provided block of text. #{formatting_instructions} Here is the provided text: #{content}"

      begin
        response = AnthropicApiClient.create_message(prompt: prompt_text, max_tokens: MAX_TOKENS)
        if response["stop_reason"] == "max_tokens"
          puts "WARNING: Response was truncated due to max_tokens limit"
        end

        response_text = response["content"][0]["text"]
        format_json_response(response_text)
      rescue JSON::ParserError => e
        puts "JSON parsing error: #{e.message}"
        puts "Response content (first 500 chars): #{response_text&.[](0..500)}"
        puts "Response content (last 200 chars): #{response_text&.[](-200..)}"
        FALLBACK_RESPONSE
      rescue => e
        puts "An error occurred: #{e.message}"
        FALLBACK_RESPONSE
      end
    end

    def format_json_response(extracted_content)
      # Strip markdown formatting more robustly
      cleaned_content = extracted_content.strip
      cleaned_content = cleaned_content.gsub(/^```json\s*/m, "").gsub(/^```\s*$/m, "").strip

      # Validate JSON complete before parsing
      unless cleaned_content.start_with?("{") && cleaned_content.end_with?("}")
        puts "WARNING: JSON response appears incomplete. First 100 chars: #{cleaned_content[0..100]}"
        puts "Last 100 chars: #{cleaned_content[-100..]}"
      end

      JSON.parse(cleaned_content)
    end

    def formatting_instructions
      <<~TEXT
        'Your response should start with { and end with } - nothing else. Do not 
        include ```json or any markdown formatting. 
        
        Use the following keys: "title", "instructions", "ingredients", "ingredients_text", "servings", "prep_time", 
        "cook_time", "total_time", "image_url". 
        
        Ingredients data will be stored redundantly in two different keys. 
        The data in the "ingredients_text" key should be stored as text with each ingredient separated by a newline character. 
        The data in the "ingredients" key should be stored as an array with each ingredient broken into its own hash with the following keys: "name", "quantity", "measurement_unit", and "preparation_style". 
        For example, an ingredient of "2 cloves of garlic, minced" would be represented as: 
        {"name": "garlic", "quantity": 2, "measurement_unit": "clove", "preparation_style": "minced"}.
        If an ingredient does not have a quantity or measurement unit, set the quantity to 1 and set the measurement_unit to "as-needed" for that ingredient.
        If an ingredient does not have a preparation_style, use a value of "" for that key.
        If an ingredient quantity has a fraction, convert it to a decimal number (e.g., 1 1/2 becomes 1.5).
        For measurement units, match to the following standard units where possible: #{Ingredient::UNITS.join(", ")}.
        If the measurement_unit is not included in that list, use a value of "as-needed" for the measurement_unit.

        The instructions should be text with each step separated by 2 newline characters. 
        
        If servings is given as a range, provide the lower number in the range. 
        
        For "prep_time", "cook_time", and "total_time", if time is given in 
        minutes, provide just the integer (and not include the word "minutes"). 
        
        If time is given in hours, convert that to minutes and provide just the integer. 
        
        If there are several image urls on the page, use the one that includes words from the recipe 
        title for the "image_url" field.'
      TEXT
    end
  end
end
