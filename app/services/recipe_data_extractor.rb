# frozen_string_literal: true

class RecipeDataExtractor
  # TODO: handle when claude totally fails. fallback to basic scraper output.
  def self.extract_from_site(source_url)
    blocked_response = "site_blocked"
    initial_prompt = "You are a helpful assistant that scrapes recipe data from a provided URL. If the site is blocked or you cannot access the recipe data, respond with the text '#{blocked_response}'. If you can access the recipe data, scrape the recipe."
    formatting_instructions = 'Your response should start with { and end with } - nothing else. Do not include ```json or any markdown formatting. Use the following keys: "title", "instructions", "ingredients", "servings", "prep_time", "cook_time", "total_time", "image_url". Ingredients should be stored as text with each ingredient separated by a newline character. The instructions should be text with each step separated by 2 newline characters. If servings is given as a range, provide the lower number in the range. For "prep_time", "cook_time", and "total_time", if time is given in minutes, provide just the integer (d not include the word "minutes"). If time is given in hours, convert that to minutes and provide just the integer. If there are several image urls on the page, use the one that includes words from the recipe title for the "image_url" field.'
    prompt_text = "#{initial_prompt} #{formatting_instructions} Here is the URL: #{source_url}"

    response = AnthropicApiClient.create_message(prompt: prompt_text)
    response_text = response["content"][0]["text"]

    extracted_content = if response_text.include?(blocked_response)
      scraped_content = Scraper.new(source_url).site_data
      prompt_text = "Please extract the recipe from the provided block of text. #{formatting_instructions} Here is the provided text: #{scraped_content}"

      response = AnthropicApiClient.create_message(prompt: prompt_text)
      response["content"][0]["text"]
    else
      response_text
    end

    JSON.parse(extracted_content.gsub("```json", "").gsub("```", "").strip)
  end

  def self.format_data(recipe:, extracted_data:)
    # TODO: build out ingredients parsing
    recipe.title = extracted_data["title"] if extracted_data["title"].present?
    recipe.instructions = extracted_data["ingredients"] + "\n\n" + extracted_data["instructions"] if extracted_data["instructions"].present? && extracted_data["ingredients"].present?
    recipe.servings = extracted_data["servings"] if extracted_data["servings"].present?
    recipe.prep_time = extracted_data["prep_time"] if extracted_data["prep_time"].present?
    recipe.cook_time = extracted_data["cook_time"] if extracted_data["cook_time"].present?
    recipe.image_url = extracted_data["image_url"] if extracted_data["image_url"].present?

    recipe
  end
end
