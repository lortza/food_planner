# frozen_string_literal: true

require "active_hash"

# This model holds the FDA Daily Values for nutrients. It needs to be updated
# manually whenever the FDA updates their guidelines.
# Source: https://www.fda.gov/food/nutrition-facts-label/daily-value-nutrition-and-supplement-facts-labels
# The usda_nutrient_id corresponds to the FDA's API https://api.nal.usda.gov/fdc/v1/foods

class UsdaDailyValues < ActiveHash::Base
  fields :usda_nutrient_id, :name, :amount, :unit
  field :required_on_label, default: false
  field :display_order, default: 0
  field :limit_type, default: nil
  field :updated_at, default: "2026-01-08"

  def display_value
    "#{value.to_i} #{unit}"
  end

  def self.label_nutrients
    where(required_on_label: true).sort_by(&:display_order)
  end

  # Note: to generate a unique uuid for new items, run this in irb:
  # require 'securerandom'
  # SecureRandom.uuid
  self.data = [
    {
      id: :calories,
      usda_nutrient_id: "",
      name: "Calories",
      amount: 2000.00,
      unit: "kcal"
    },
    {
      id: :added_sugar_g,
      usda_nutrient_id: "1063",
      name: "Added Sugars",
      amount: 50.00,
      unit: "g",
      limit_type: "upper",
      required_on_label: true,
      display_order: 7
    },
    {
      id: :biotin,
      usda_nutrient_id: "1176",
      name: "Biotin",
      amount: 30.00,
      unit: "mcg"
    },
    {
      id: :calcium_mg,
      usda_nutrient_id: "1087",
      name: "Calcium",
      amount: 1300.00,
      unit: "mg",
      required_on_label: true,
      display_order: 10
    },
    {
      id: :chloride,
      usda_nutrient_id: "",
      name: "Chloride",
      amount: 2300.00,
      unit: "mg"
    },
    {
      id: :choline_mg,
      usda_nutrient_id: "1180",
      name: "Choline",
      amount: 550.00,
      unit: "mg"
    },
    {
      id: :cholesterol_mg,
      usda_nutrient_id: "1253",
      name: "Cholesterol",
      amount: 300.00,
      unit: "mg",
      limit_type: "upper",
      required_on_label: true,
      display_order: 3
    },
    {
      id: :chromium_mcg,
      usda_nutrient_id: "",
      name: "Chromium",
      amount: 35.00,
      unit: "mcg"
    },
    {
      id: :copper_mg,
      usda_nutrient_id: "1098",
      name: "Copper",
      amount: 0.90,
      unit: "mg"
    },
    {
      id: :fiber_g,
      usda_nutrient_id: "1079",
      name: "Dietary Fiber",
      amount: 28.00,
      unit: "g",
      limit_type: "lower",
      required_on_label: true,
      display_order: 6
    },
    {
      id: :fat_total_g,
      usda_nutrient_id: "1004",
      name: "Total Fat",
      amount: 78.00,
      unit: "g",
      limit_type: "upper",
      required_on_label: true,
      display_order: 1
    },
    {
      id: :folate_mcg_dfe,
      usda_nutrient_id: "1177",
      name: "Folate/Folic Acid",
      amount: 400.00,
      unit: "mcg DFE"
    },
    {
      id: :iodine_mcg,
      usda_nutrient_id: "1100",
      name: "Iodine",
      amount: 150.00,
      unit: "mcg"
    },
    {
      id: :iron_mg,
      usda_nutrient_id: "1089",
      name: "Iron",
      amount: 18.00,
      unit: "mg",
      required_on_label: true,
      display_order: 11
    },
    {
      id: :magnesium_mg,
      usda_nutrient_id: "1090",
      name: "Magnesium",
      amount: 420.00,
      unit: "mg"
    },
    {
      id: :manganese_mg,
      usda_nutrient_id: "1101",
      name: "Manganese",
      amount: 2.3,
      unit: "mg"
    },
    {
      id: :molybdenum_mcg,
      usda_nutrient_id: "1102",
      name: "Molybdenum",
      amount: 45.00,
      unit: "mcg"
    },
    {
      id: :niacin_mg_ne,
      usda_nutrient_id: "1167",
      name: "Niacin",
      amount: 16.00,
      unit: "mg NE"
    },
    {
      id: :pantothenic_acid_mg,
      usda_nutrient_id: "1170",
      name: "Pantothenic Acid",
      amount: 5.00,
      unit: "mg"
    },
    {
      id: :phosphorus_mg,
      usda_nutrient_id: "1091",
      name: "Phosphorus",
      amount: 1250.00,
      unit: "mg"
    },
    {
      id: :potassium_mg,
      usda_nutrient_id: "1092",
      name: "Potassium",
      amount: 4700.00,
      unit: "mg",
      required_on_label: true,
      display_order: 12
    },
    {
      id: :protein_g,
      usda_nutrient_id: "1003",
      name: "Protein",
      amount: 50.00,
      unit: "g",
      display_order: 8
    },
    {
      id: :riboflavin_mg,
      usda_nutrient_id: "1166",
      name: "Riboflavin",
      amount: 1.3,
      unit: "mg"
    },
    {
      id: :fat_saturated_g,
      usda_nutrient_id: "1258",
      name: "Saturated fat",
      amount: 20.00,
      unit: "g",
      required_on_label: true,
      display_order: 2
    },
    {
      id: :selenium_mcg,
      usda_nutrient_id: "1103",
      name: "Selenium",
      amount: 55.00,
      unit: "mcg"
    },
    {
      id: :sodium_mg,
      usda_nutrient_id: "1093",
      name: "Sodium",
      amount: 2300.00,
      unit: "mg",
      required_on_label: true,
      display_order: 4
    },
    {
      id: :thiamin_mg,
      usda_nutrient_id: "1165",
      name: "Thiamin",
      amount: 1.2,
      unit: "mg"
    },
    {
      id: :carbohydrates_total_g,
      usda_nutrient_id: "1005",
      name: "Total Carbohydrate",
      amount: 275.00,
      unit: "g",
      required_on_label: true,
      display_order: 5
    },
    {
      id: :vitamin_a_mcg_rae,
      usda_nutrient_id: "2066",
      name: "Vitamin A",
      amount: 900.00,
      unit: "mcg RAE"
    },
    {
      id: :vitamin_b6_mg,
      usda_nutrient_id: "1175",
      name: "Vitamin B6",
      amount: 1.7,
      unit: "mg"
    },
    {
      id: :vitamin_b12_mcg,
      usda_nutrient_id: "1178",
      name: "Vitamin B12",
      amount: 2.4,
      unit: "mcg"
    },
    {
      id: :vitamin_c_mg,
      usda_nutrient_id: "1162",
      name: "Vitamin C",
      amount: 90.00,
      unit: "mg"
    },
    {
      id: :vitamin_d_mcg,
      usda_nutrient_id: "1114",
      name: "Vitamin D",
      amount: 20.00,
      unit: "mcg",
      required_on_label: true,
      display_order: 9
    },
    {
      id: :vitamin_e_mg_alpha_tocopherol,
      usda_nutrient_id: "1109",
      name: "Vitamin E",
      amount: 15.00,
      unit: "mg alpha-tocopherol"
    },
    {
      id: :vitamin_k_mcg,
      usda_nutrient_id: "1184",
      name: "Vitamin K",
      amount: 120.00,
      unit: "mcg"
    },
    {
      id: :zinc_mg,
      usda_nutrient_id: "1095",
      name: "Zinc",
      amount: 11.00,
      unit: "mg"
    }
  ]
end
