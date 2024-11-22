# frozen_string_literal: true

module MealPlansHelper
  def display_recipes(meal_plan)
    raw(meal_plan.recipes.map do |recipe|
      link_to recipe.title, recipe
    end.join(", "))
  end

  def meal_plan_ingredient_ids(ingredient_set)
    # ingredient_set is a hash where the key is
    # a recipe, and the values are ingredients
    ingredient_set.values.flatten.pluck(:id)
  end
end
