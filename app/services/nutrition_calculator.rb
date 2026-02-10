# frozen_string_literal: true

class NutritionCalculator
  def initialize(recipe)
    @recipe = recipe
  end

  def calculate_and_save
    query_string = build_ingredient_query

    # Get data from both APIs
    api_ninjas_data = ApiNinjaClient.get_nutrition_from_freeform(query_string)
    usda_data = fetch_protein_calories_from_usda(@recipe.ingredients)

    # Merge and calculate totals
    nutrition_data = merge_nutrition_data(api_ninjas_data, usda_data)

    @recipe.nutrition_profile.presence || NutritionProfile.new(recipe: @recipe)
    @recipe.nutrition_profile.update!(nutrition_data.merge(
      servings: @recipe.servings,
      api_source: "api_ninjas_usda_hybrid",
      last_calculated_at: Time.current
    ))
  end

  private

  def build_ingredient_query
    @recipe.ingredients.map do |ingredient|
      ingredient_to_line(ingredient)
    end.join(" ")
  end

  def ingredient_to_line(ingredient)
    "#{ingredient.quantity} #{ingredient.measurement_unit} #{ingredient.name}"
  end

  def fetch_protein_calories_from_usda(recipe_ingredients)
    totals = {calories: 0, protein_g: 0}

    recipe_ingredients.each do |ingredient|
      # Search USDA for this ingredient
      search_result = usda_search(ingredient.name)
      next unless search_result

      # Convert quantity to grams
      amount_g = convert_to_grams(quantity: ingredient.quantity, measurement_unit: ingredient.measurement_unit)

      # Calculate based on 100g reference
      ratio = amount_g / 100.0
      totals[:calories] += (search_result[:calories] * ratio)
      totals[:protein_g] += (search_result[:protein] * ratio)
    end
    totals
  end

  def usda_search(ingredient_name)
    data = UsdaFoodDataCentralApiClient.get_foods_search(ingredient_name)
    return nil if data[:foods].empty?

    food = data[:foods].first
    nutrients = food[:foodNutrients]

    {
      calories: find_nutrient(nutrients: nutrients, name: "Energy", unit: "kcal"),
      protein: find_nutrient(nutrients: nutrients, name: "Protein", unit: "g")
    }
  rescue => e
    Rails.logger.error("USDA API error: #{e.message}")
    nil
  end

  def find_nutrient(nutrients:, name:, unit:)
    nutrient = nutrients.find do |n|
      n[:nutrientName]&.downcase&.include?(name.downcase) && n[:unitName]&.downcase == unit.downcase
    end
    nutrient ? nutrient[:value].to_f : 0
  end

  def merge_nutrition_data(api_ninjas_data, usda_data)
    # Sum up API Ninjas data across all ingredients
    summed_api_ninjas_data = api_ninjas_data.each_with_object({}) do |hash, result|
      hash.each do |nutrient_name, value|
        result[nutrient_name] ||= 0
        result[nutrient_name] += value if value.is_a?(Numeric)
      end
    end

    summed_api_ninjas_data.except(:name).merge(usda_data)
  end

  def convert_to_grams(quantity:, measurement_unit:)
    # Simple conversion helper
    case measurement_unit.downcase
    when "lb", "lbs", "pound", "pounds"
      quantity * 453.592
    when "oz", "ounce", "ounces"
      quantity * 28.3495
    when "cup", "cups"
      quantity * 240 # approximate, varies by ingredient
    when "tbsp", "tablespoon", "tablespoons"
      quantity * 15
    when "tsp", "teaspoon", "teaspoons"
      quantity * 5
    when "g", "gram", "grams"
      quantity
    else
      # Default estimate
      quantity * 100
    end
  end

  ################# MY STUFF FOR TESTING PURPOSES ONLY #################
  # TODO: build specific API client that knows how to parse this API response. IN the meantime, MAGIC:
  def self.magic_values_per_serving
    servings = 4
    totals = {
      calories: 0,
      fat_total_g: 0,
      fat_saturated_g: 0,
      protein_g: 0,
      sodium_mg: 0,
      potassium_mg: 0,
      cholesterol_mg: 0,
      carbohydrates_total_g: 0,
      fiber_g: 0,
      sugar_g: 0
    }
    SAMPLE_DATA.each do |item|
      totals[:calories] += item[:calories].is_a?(Numeric) ? item[:calories] : 0
      totals[:fat_total_g] += item[:fat_total_g]
      totals[:fat_saturated_g] += item[:fat_saturated_g]
      totals[:protein_g] += item[:protein_g].is_a?(Numeric) ? item[:protein_g] : 0
      totals[:sodium_mg] += item[:sodium_mg]
      totals[:potassium_mg] += item[:potassium_mg]
      totals[:cholesterol_mg] += item[:cholesterol_mg]
      totals[:carbohydrates_total_g] += item[:carbohydrates_total_g]
      totals[:fiber_g] += item[:fiber_g]
      totals[:sugar_g] += item[:sugar_g]
    end
    # Recipe total divided by servings
    totals.transform_values do |value|
      (value / servings).round(2)
    end
  end

  def self.magic_daily_percentages
    data_mappings = {
      calories: :calories,
      fat_total_g: :fat_total_g,
      protein_g: :protein_g,
      sodium_mg: :sodium_mg,
      potassium_mg: :potassium_mg,
      cholesterol_mg: :cholesterol_mg,
      carbohydrates_total_g: :carbohydrates_total_g,
      fiber_g: :fiber_g,
      sugar_g: :added_sugar_g
    }
    magic_values_per_serving.map do |k, v|
      derived_id = data_mappings[k]
      line = {k => (v / UsdaDailyValues.find(derived_id).amount * 100).round(0)}
      puts line
      line
    end.to_h
  end

  SAMPLE_DATA = [
    {
      name: "chicken thighs",
      calories: "Only available for premium subscribers.",
      serving_size_g: 907.184,
      fat_total_g: 127.3,
      fat_saturated_g: 37.8,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 1554,
      potassium_mg: 1752,
      cholesterol_mg: 1165,
      carbohydrates_total_g: 0.8,
      fiber_g: 0.0,
      sugar_g: 0.0
    },
    {
      name: "salt",
      calories: "Only available for premium subscribers.",
      serving_size_g: 1.5,
      fat_total_g: 0.0,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 575,
      potassium_mg: 0,
      cholesterol_mg: 0,
      carbohydrates_total_g: 0.0,
      fiber_g: 0.0,
      sugar_g: 0.0
    },
    {
      name: "black pepper",
      calories: "Only available for premium subscribers.",
      serving_size_g: 2.3,
      fat_total_g: 0.1,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 0,
      potassium_mg: 3,
      cholesterol_mg: 0,
      carbohydrates_total_g: 1.5,
      fiber_g: 0.6,
      sugar_g: 0.0
    },
    {
      name: "olive oil",
      calories: "Only available for premium subscribers.",
      serving_size_g: 28.35,
      fat_total_g: 28.7,
      fat_saturated_g: 3.9,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 0,
      potassium_mg: 0,
      cholesterol_mg: 0,
      carbohydrates_total_g: 0.0,
      fiber_g: 0.0,
      sugar_g: 0.0
    },
    {
      name: "onion",
      calories: "Only available for premium subscribers.",
      serving_size_g: 94.0,
      fat_total_g: 0.2,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 2,
      potassium_mg: 32,
      cholesterol_mg: 0,
      carbohydrates_total_g: 9.5,
      fiber_g: 1.3,
      sugar_g: 4.4
    },
    {
      name: "bell pepper",
      calories: "Only available for premium subscribers.",
      serving_size_g: 114.0,
      fat_total_g: 0.2,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 2,
      potassium_mg: 20,
      cholesterol_mg: 0,
      carbohydrates_total_g: 7.8,
      fiber_g: 1.4,
      sugar_g: 3.6
    },
    {
      name: "clove garlic",
      calories: "Only available for premium subscribers.",
      serving_size_g: 12.0,
      fat_total_g: 0.1,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 2,
      potassium_mg: 18,
      cholesterol_mg: 0,
      carbohydrates_total_g: 3.9,
      fiber_g: 0.2,
      sugar_g: 0.1
    },
    {
      name: "jerk seasoning",
      calories: "Only available for premium subscribers.",
      serving_size_g: 42.525000000000006,
      fat_total_g: 11.6,
      fat_saturated_g: 0.9,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 1999,
      potassium_mg: 6,
      cholesterol_mg: 0,
      carbohydrates_total_g: 24.7,
      fiber_g: 0.9,
      sugar_g: 22.5
    },
    {
      name: "thyme",
      calories: "Only available for premium subscribers.",
      serving_size_g: 5.69,
      fat_total_g: 0.1,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 0,
      potassium_mg: 6,
      cholesterol_mg: 0,
      carbohydrates_total_g: 1.4,
      fiber_g: 0.8,
      sugar_g: 0.0
    },
    {
      name: "allspice",
      calories: "Only available for premium subscribers.",
      serving_size_g: 2.845,
      fat_total_g: 0.3,
      fat_saturated_g: 0.1,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 2,
      potassium_mg: 3,
      cholesterol_mg: 0,
      carbohydrates_total_g: 2.1,
      fiber_g: 0.6,
      sugar_g: 0.0
    },
    {
      name: "scotch bonnet pepper",
      calories: "Only available for premium subscribers.",
      serving_size_g: 45.0,
      fat_total_g: 0.2,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 4,
      potassium_mg: 19,
      cholesterol_mg: 0,
      carbohydrates_total_g: 3.9,
      fiber_g: 0.7,
      sugar_g: 2.4
    },
    {
      name: "chicken broth",
      calories: "Only available for premium subscribers.",
      serving_size_g: 250.0,
      fat_total_g: 0.5,
      fat_saturated_g: 0.0,
      protein_g: "Only available for premium subscribers.",
      sodium_mg: 932,
      potassium_mg: 9,
      cholesterol_mg: 5,
      carbohydrates_total_g: 1.1,
      fiber_g: 0.0,
      sugar_g: 1.1
    }
  ]
end
