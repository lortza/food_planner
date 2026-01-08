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
#  serving_size          :string
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
  
end

