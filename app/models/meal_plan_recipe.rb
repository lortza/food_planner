# frozen_string_literal: true

# == Schema Information
#
# Table name: meal_plan_recipes
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  meal_plan_id :bigint
#  recipe_id    :bigint
#
# Indexes
#
#  index_meal_plan_recipes_on_meal_plan_id  (meal_plan_id)
#  index_meal_plan_recipes_on_recipe_id     (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_plan_id => meal_plans.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
class MealPlanRecipe < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :recipe

  validates :recipe_id, uniqueness: {scope: :meal_plan_id}
end
