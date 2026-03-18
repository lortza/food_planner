# frozen_string_literal: true

class IngredientSet
  def self.build_set(meal_plan)
    Ingredient.where(recipe_id: meal_plan.recipe_ids)
      .includes(:recipe)
      .order(:name)
      .group_by(&:name)

    # WIP = Ingredient.select('ingredients.*')
    #         .joins('INNER JOIN recipes ON recipes.id = ingredients.recipe_id')

    #         .joins('INNER JOIN meal_plan_recipes ON meal_plan_recipes.recipe_id = recipes.id')
    #         .joins('INNER JOIN meal_plans ON meal_plans.id = meal_plan_recipes.meal_plan_id')
    #         .where("meal_plan_id = #{meal_plan.id}")
    #         .group('ingredients.name')
  end
end
