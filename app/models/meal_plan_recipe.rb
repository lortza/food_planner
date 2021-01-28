# frozen_string_literal: true

class MealPlanRecipe < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :recipe

  validates :recipe_id, uniqueness: { scope: :meal_plan_id }

  after_create :update_recipe_last_prepared_date
  after_destroy :update_recipe_last_prepared_date

  private

  def update_recipe_last_prepared_date
    recipe = Recipe.find(recipe_id)
    date = recipe.calculate_last_prepared_on
    recipe.update_columns(last_prepared_on: date)
  end
end
