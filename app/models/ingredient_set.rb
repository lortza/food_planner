# frozen_string_literal: true

class IngredientSet
  def self.build_set(meal_plan)
    plan_recipe_ids = meal_plan.recipes.pluck(:id)
    Ingredient.where(recipe_id: plan_recipe_ids)
              .includes(:recipe)
              .group_by(&:name)
  end
end
