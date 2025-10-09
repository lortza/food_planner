# frozen_string_literal: true

#
#
# curl https://api.anthropic.com/v1/messages \
#      --header "x-api-key: $ANTHROPIC_API_KEY" \
#      --header "anthropic-version: 2023-06-01" \
#      --header "content-type: application/json" \
#      --data \
# '{
#     "model": "claude-sonnet-4-5",
#     "max_tokens": 1024,
#     "messages": [
#         {"role": "user", "content": "Hello, world"}
#     ]
# }'

class ClaudeApiClient
  require "httparty"
  BASE_URL = "https://api.anthropic.com/v1/messages"

  SAMPLE_SCRAPER_OUTPUT = <<~SCRAPER_OUTPUT
    What to Cook
    Recipes
    Ingredients
    Occasions
    About
    Staff PicksEasy Salmon RecipesSoups and StewsEasy Side DishesHealthy Weeknight DinnersSheet-Pan Vegetarian Recipes
    Easy Salmon Recipes
    Soups and Stews
    Quinoa
    Bread
    Couscous
    Canadian Thanksgiving
    Diwali
    Halloween
    Thanksgiving
    Birthdays
    Brunch
    Date Night
    Parties
    Picnics
    About Us
    The New York Times Food Section
    SaveLog in or sign up to save this recipe.
    GiveSubscriber benefit: Give recipes to anyoneAs a subscriber, you have 10 gift recipes to give each month. Anyone can view them - even nonsubscribers. Learn more.SubscribeLog In
    Share this recipeCopy linkEmailPinterestFacebookXWhatsAppReddit
    Copy link
    Email
    Pinterest
    Facebook
    X
    WhatsApp
    Reddit
    Print this recipeInclude recipe photoPrint Recipe
    1bunch cilantro
    1white onion
    6garlic cloves
    2pounds tomatillos
    3large poblano chiles
    1jalapeño
    1lime, plus wedges for serving, if you like
    4 to 6tablespoons olive oil
    Salt
    2teaspoons ground cumin
    2teaspoons dried oregano
    1bunch lacinato kale, stemmed and chopped into bite-size pieces (or 4 tightly packed cups, about 8 ounces, chopped hardy greens)
    2(15-ounce) cans hominy, drained
    4cups store-bought or homemade vegetable broth
    2 to 3cups shredded green cabbage
    2 to 4radishes, thinly sliced
    1jalapeño, thinly sliced
    Queso fresco (about 3 tablespoons per bowl)
    Crema or sour cream (about 2 tablespoons per bowl)
    Flaky salt
    Sliced avocado (optional)
    Step 1Heat oven to 475 degrees.
    Step 2Prepare the soup: Separate the cilantro leaves and tender stems from the thicker stems. Place the thicker stems on a large sheet pan and refrigerate the remaining until ready to serve the soup.
    Step 3Halve and peel the onion. Cut half into rough wedges and place on the sheet pan; finely dice the second half and set aside. Peel the garlic cloves; place 3 whole cloves on the sheet pan, then mince the remaining 3 cloves and set aside. Peel and quarter the tomatillos; halve, seed and stem the poblanos and jalapeño; and halve the lime; add all to the pan.
    Taco SoupNaz Deravian
    Pozole VerdeDavid Tanis
    Caldo Verde (Potato and Greens Soup With Sausage)Kay Chun
    Martha Rose Shulman’s Tortilla SoupMartha Rose Shulman
    Vegetable SoupLidey Heuck
    Slow Cooker Shortcut Chicken PozoleSarah DiGregorio
    Mexican Chicken Soup With Chick Peas, Avocado and ChipotlesMartha Rose Shulman
    Seared Broccoli and Potato SoupMelissa Clark
    Best GazpachoJulia Moskin
    Matzo Ball Soup a la MexicanaPriya Krishna
    One-Pot French Onion Soup With Porcini MushroomsSusan Spungen
    All Comments
    Private
    Mexican
    Southwestern
    Cilantro
    Food Processor
    Great Leftover
    Jalapeno
    Poblano
    Soup
    Sturdy Green
    Tomatillo
    Dinner
    Lunch
    Main Course
    Fall
    Winter
    Healthy
    Vegetarian
    Skillet Gnocchi Alla VodkaSheela Prakash622 ratings with an average rating of 5 out of 5 stars62235 minutesLog in or sign up to save this recipe.Easy
    Huevos Enfrijolados (Eggs in Spicy Black Beans)Rick Martinez411 ratings with an average rating of 5 out of 5 stars41140 minutesLog in or sign up to save this recipe.Easy
    Vegan CheeseburgersJ. Kenji López-Alt493 ratings with an average rating of 4 out of 5 stars49315 minutesLog in or sign up to save this recipe.Easy
    Paneer Chile DryZainab Shah489 ratings with an average rating of 4 out of 5 stars48930 minutesLog in or sign up to save this recipe.
    Crispy Halloumi With Tomatoes and White BeansNargisse Benkabbou5007 ratings with an average rating of 5 out of 5 stars5,00730 minutes Log in or sign up to save this recipe.Easy
    Sheet-Pan BibimbapEric Kim7361 ratings with an average rating of 5 out of 5 stars7,36135 minutesLog in or sign up to save this recipe.
    No-Cook Chili Bean SaladHetty Lui McKinnon733 ratings with an average rating of 5 out of 5 stars73325 minutes Log in or sign up to save this recipe.Easy
    Kung Pao Tofu Ham El-Waylly4449 ratings with an average rating of 5 out of 5 stars4,4491 hourLog in or sign up to save this recipe.Easy
    Hoisin Garlic NoodlesHetty Lui McKinnon2683 ratings with an average rating of 5 out of 5 stars2,68325 minutesLog in or sign up to save this recipe.Easy
    Crispy Potato QuesadillasKristina Felix683 ratings with an average rating of 5 out of 5 stars68335 minutesLog in or sign up to save this recipe.Easy
    Farro and Bean Chili Ali Slagle597 ratings with an average rating of 5 out of 5 stars5971 hourLog in or sign up to save this recipe.
    Vegetarian Pad ThaiHetty Lui McKinnon354 ratings with an average rating of 4 out of 5 stars35440 minutesLog in or sign up to save this recipe.Healthy
    FAQ
    NYTimes.com/food
    Gift Subscription
    Merchandise
    Send Us Feedback
    From Our Newsletters
    Weeknight
    Pasta
    Dinner
    Healthy
    Vegetarian
    Vegan
    Thanksgiving
    Christmas
    © 2025 The New York Times Company
    Terms of Service
    Privacy Policy
    Cookie Policy
  SCRAPER_OUTPUT

  def self.post_to_claude(prompt)
    response = HTTParty.post(
      BASE_URL,
      headers: {
        "x-api-key" => Rails.application.credentials.anthropic_api_key,
        "anthropic-version" => "2023-06-01",
        "content-type" => "application/json"
      },
      body: {
        model: "claude-sonnet-4-5",
        max_tokens: 1024,
        messages: [{role: "user", content: prompt}]
      }.to_json
    )

    puts response.parsed_response
    response["content"][0]["text"]
  end

  def self.extract_recipe_data_from_site(source_url)
    blocked_response = "site_blocked"
    initial_prompt = "You are a helpful assistant that scrapes recipe data from a provided URL. If the site is blocked or you cannot access the recipe data, respond with the text '#{blocked_response}'. If you can access the recipe data, scrape the recipe."
    formatting_instructions = 'Your response should start with { and end with } - nothing else. Do not include ```json or any markdown formatting. Use the following keys: "title", "instructions", "ingredients", "servings", "prep_time", "cook_time", "total_time", "image_url". Ingredients should be stored as text with each ingredient separated by a newline character. The instructions should be text with each step separated by 2 newline characters. If servings is given as a range, provide the lower number in the range. For "prep_time", "cook_tie", and "total_time", if time is given in minutes, provide just the integer (d not include the word "minutes"). If time is given in hours, convert that to minutes and provide just the integer.'
    prompt_text = "#{initial_prompt} #{formatting_instructions} Here is the URL: #{source_url}"

    response_text = post_to_claude(prompt_text)
    binding.pry
    extracted_content = if response_text.include?(blocked_response)
      scraped_content = Scraper.new(source_url).site_data
      binding.pry
      prompt_text = "Please extract the recipe from the provided block of text. #{formatting_instructions} Here is the URL: #{source_url}"

      response_text = post_to_claude(prompt_text)
      binding.pry
      response_text
    else
      binding.pry
      response_text
    end
    JSON.parse(extracted_content)
  end

  # ClaudeApiClient.extract_recipe_data_from_site("https://cooking.nytimes.com/recipes/1024490-tortellini-soup")

  def self.extract_recipe_data_from_scraped_content(scraped_text)
    # SAMPLE_INSTRUCTIONS = 'Please extract the recipe from the provided block of text. Your response should start with { and end with } - nothing else. Do not include ```json or any markdown formatting. Use the following keys: "instructions", "ingredients". The "ingredients" key should be an array and each ingredient should be broken down into its parts with these keys: "quantity", "unit_of_measurement", "item", "preparation_style". The provided block of text:'
    # prompt_instructions = 'Please extract the recipe from the provided block of text. Your response should start with { and end with } - nothing else. Do not include ```json or any markdown formatting. Use the following keys: "instructions", "ingredients". The provided block of text:'
    prompt_instructions = "Please extract the recipe from the provided block of text. Your response should be in text format. Start with the ingredients and separate each ingredient with a newline. Then add three newlines and list all of the instructions. Each step of the instructions should be separated by 2 newline characters. The provided block of text:"
    prompt_text = "#{prompt_instructions}\n\n#{scraped_text}"

    response_text = post_to_claude(prompt_text)
    binding.pry
    response_text
    # parsed_text = JSON.parse(response_text)
    # {
    #   ingredients: parsed_text["ingredients"],
    #   instructions: parsed_text["instructions"]
    # }
  end
end

# {
#   "model" => "claude-sonnet-4-5-20250929",
#   "id" => "msg_01JXfLp8D6nC6UnRM3eoASuo",
#   "type" => "message",
#   "role" => "assistant",
#   "content" => [{
#     "type" => "text",
#     "text" => "# Five Common Indian Soup Ingredients\n\n1. **Lentils (Dal)** - Red lentils, yellow lentils, or split peas form the base of many Indian soups like dal soup\n\n2. **Cumin** - A quintessential spice used for tempering and flavoring, often toasted to release its aroma\n\n3. **Ginger** - Fresh ginger root adds warmth and a spicy-sweet flavor to soups\n\n4. **Turmeric** - Provides earthy flavor, golden color, and anti-inflammatory properties\n\n5. **Coconut Milk** - Common in South Indian soups, adding creaminess and subtle sweetness\n\nThese ingredients often work together in popular soups like mulligatawny, rasam, and various dal-based soups."
#   }],
#   "stop_reason" => "end_turn",
#   "stop_sequence" => nil,
#   "usage" => {
#     "input_tokens" => 19,
#     "cache_creation_input_tokens" => 0,
#     "cache_read_input_tokens" => 0,
#     "cache_creation" => {"ephemeral_5m_input_tokens" => 0, "ephemeral_1h_input_tokens" => 0},
#     "output_tokens" => 184,
#     "service_tier" => "standard"
#   }
# }

# {"model" => "claude-sonnet-4-5-20250929",
#  "id" => "msg_01UCCQXaxyZRfGtQpiZHSJZR",
#  "type" => "message", "role" => "assistant",
#  "content" => [{
#    "type" => "text",
#    "text" => "```json\n{\n  \"ingredients\": [\n    \"1 bunch cilantro\",\n    \"1 white onion\",\n    \"6 garlic cloves\",\n    \"2 pounds tomatillos\",\n    \"3 large poblano chiles\",\n    \"1 jalapeño\",\n    \"1 lime, plus wedges for serving, if you like\",\n    \"4 to 6 tablespoons olive oil\",\n    \"Salt\",\n    \"2 teaspoons ground cumin\",\n    \"2 teaspoons dried oregano\",\n    \"1 bunch lacinato kale, stemmed and chopped into bite-size pieces (or 4 tightly packed cups, about 8 ounces, chopped hardy greens)\",\n    \"2 (15-ounce) cans hominy, drained\",\n    \"4 cups store-bought or homemade vegetable broth\",\n    \"2 to 3 cups shredded green cabbage\",\n    \"2 to 4 radishes, thinly sliced\",\n    \"1 jalapeño, thinly sliced\",\n    \"Queso fresco (about 3 tablespoons per bowl)\",\n    \"Crema or sour cream (about 2 tablespoons per bowl)\",\n    \"Flaky salt\",\n    \"Sliced avocado (optional)\"\n  ],\n  \"instructions\": [\n    \"Heat oven to 475 degrees.\",\n    \"Prepare the soup: Separate the cilantro leaves and tender stems from the thicker stems. Place the thicker stems on a large sheet pan and refrigerate the remaining until ready to serve the soup.\",\n    \"Halve and peel the onion. Cut half into rough wedges and place on the sheet pan; finely dice the second half and set aside. Peel the garlic cloves; place 3 whole cloves on the sheet pan, then mince the remaining 3 cloves and set aside. Peel and quarter the tomatillos; halve, seed and stem the poblanos and jalapeño; and halve the lime; add all to the pan.\"\n  ]\n}\n```"
#  }], "stop_reason" => "end_turn", "stop_sequence" => nil,
#  "usage" => {"input_tokens" => 1634, "cache_creation_input_tokens" => 0, "cache_read_input_tokens" => 0, "cache_creation" => {"ephemeral_5m_input_tokens" => 0, "ephemeral_1h_input_tokens" => 0},
#              "output_tokens" => 510, "service_tier" => "standard"}}
