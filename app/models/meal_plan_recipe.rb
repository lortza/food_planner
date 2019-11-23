# frozen_string_literal: true

class MealPlanRecipe < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :recipe

  validates :meal_plan_id,
            :recipe_id,
            presence: true

  validates :recipe_id, uniqueness: { scope: :meal_plan_id }
end
