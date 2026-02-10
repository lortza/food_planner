# frozen_string_literal: true

# == Schema Information
#
# Table name: nutrition_profiles
#
#  id                    :uuid             not null, primary key
#  added_sugar_g         :decimal(8, 2)
#  api_response_data     :jsonb
#  api_source            :string
#  calcium_mg            :decimal(8, 2)
#  calories              :decimal(8, 2)
#  carbohydrates_total_g :decimal(8, 2)
#  cholesterol_mg        :decimal(8, 2)
#  fat_saturated_g       :decimal(8, 2)
#  fat_total_g           :decimal(8, 2)
#  fat_trans_g           :decimal(8, 2)
#  fiber_g               :decimal(8, 2)
#  iron_mg               :decimal(8, 2)
#  last_calculated_at    :datetime
#  potassium_mg          :decimal(8, 2)
#  protein_g             :decimal(8, 2)
#  serving_size_g        :string
#  servings              :integer
#  sodium_mg             :decimal(8, 2)
#  sugar_g               :decimal(8, 2)
#  vitamin_d_mcg         :decimal(8, 2)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  recipe_id             :bigint           not null
#
# Indexes
#
#  index_nutrition_profiles_on_recipe_id  (recipe_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
class NutritionProfile < ApplicationRecord
  belongs_to :recipe, inverse_of: :nutrition_profile

  def fetch_nutrition_data
    freeform_text = recipe.ingredients.map do |ingredient|
      "#{ingredient.quantity} #{ingredient.measurement_unit} #{ingredient.name}"
    end.join(" ")
    nutrition_data = ApiNinjaClient.get_nutrition_from_freeform(freeform_text)

    update(
      api_response_data: nutrition_data,
      api_source: "ApiNinja",
      calories: nutrition_data.sum { |item| item["calories"].to_f },
      servings: recipe.servings,
      serving_size_g: nutrition_data.sum { |item| item["serving_size_g"].to_f },
      fat_total_g: nutrition_data.sum { |item| item["fat_total_g"].to_f },
      fat_saturated_g: nutrition_data.sum { |item| item["fat_saturated_g"].to_f },
      protein_g: nutrition_data.sum { |item| item["protein_g"].to_f },
      sodium_mg: nutrition_data.sum { |item| item["sodium_mg"].to_f },
      potassium_mg: nutrition_data.sum { |item| item["potassium_mg"].to_f },
      cholesterol_mg: nutrition_data.sum { |item| item["cholesterol_mg"].to_f },
      carbohydrates_total_g: nutrition_data.sum { |item| item["carbohydrates_total_g"].to_f },
      fiber_g: nutrition_data.sum { |item| item["fiber_g"].to_f },
      sugar_g: nutrition_data.sum { |item| item["sugar_g"].to_f },
      last_calculated_at: Time.current
    )
  end

  # Calculate %DV for display
  # def percent_daily_values
  #   {
  #     fat_total: calculate_percent_dv(amount: fat_total_g, nutrient_name: 'total_fat'),
  #     fat_saturated: calculate_percent_dv(amount: fat_saturated_g, nutrient_name: 'saturated_fat'),
  #     cholesterol: calculate_percent_dv(amount: cholesterol_mg, nutrient_name: 'cholesterol'),
  #     sodium: calculate_percent_dv(amount: sodium_mg, nutrient_name: 'sodium'),
  #     carbohydrates_total: calculate_percent_dv(amount: carbohydrates_total_g, nutrient_name: 'total_carbohydrate'),
  #     fiber: calculate_percent_dv(amount: fiber_g, nutrient_name: 'dietary_fiber'),
  #     potassium: calculate_percent_dv(amount: potassium_mg, nutrient_name: 'potassium'),
  #     calcium: calculate_percent_dv(amount: calcium_mg, nutrient_name: 'calcium'),
  #     iron: calculate_percent_dv(amount: iron_mg, nutrient_name: 'iron'),
  #     vitamin_d: calculate_percent_dv(amount: vitamin_d_mcg, nutrient_name: 'vitamin_d')
  #   }
  # end

  # def per_serving
  #   return self if servings.nil? || servings <= 1

  #   OpenStruct.new(
  #     calories: (calories / servings).round(1),
  #     protein_g: (protein_g / servings).round(1),
  #     fat_total_g: (fat_total_g / servings).round(1),
  #     fat_saturated_g: (fat_saturated_g / servings).round(1),
  #     cholesterol_mg: (cholesterol_mg / servings).round(0),
  #     sodium_mg: (sodium_mg / servings).round(0),
  #     carbohydrates_total_g: (carbohydrates_total_g / servings).round(1),
  #     fiber_g: (fiber_g / servings).round(1),
  #     sugar_g: (sugar_g / servings).round(1),
  #     potassium_mg: (potassium_mg / servings).round(0)
  #   )
  # end

  # def to_label_format
  #   per_serving_data = per_serving
  #   percent_dvs = percent_daily_values

  #   {
  #     servings: servings,
  #     serving_size: serving_size,
  #     per_serving: per_serving_data,
  #     percent_dv: percent_dvs,
  #     last_updated: last_calculated_at
  #   }
  # end

  # private

  # def calculate_percent_dv(amount:, nutrient_name)
  #   return nil if amount.nil?

  #   reference = UsdaDailyValues.find_by(nutrient_name: nutrient_name)
  #   return nil unless reference

  #   ((amount / reference.daily_value_amount) * 100).round(0)
  # end
end
