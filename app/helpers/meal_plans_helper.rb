# frozen_string_literal: true

module MealPlansHelper
  def display_recipes(meal_plan)
    meal_plan.recipes.map(&:title).join(', ')
  end

  def meal_plan_ingredient_ids(ingredient_set)
    # ingredient_set is a hash where the key is
    # a recipe, and the values are ingredients
    ingredient_set.values.flatten.pluck(:id)
  end
end
