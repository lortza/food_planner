# frozen_string_literal: true

module MealPlansHelper
  def display_recipes(meal_plan)
    meal_plan.recipes.includes(:meal_plan_recipes).map(&:title).join(', ')
  end
end
