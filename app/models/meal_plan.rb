# frozen_string_literal: true

class MealPlan < ApplicationRecord
  has_many :meal_plan_recipes, dependent: :nullify
  has_many :recipes, through: :meal_plan_recipes

  def self.ordered
    all.order(start_date: :DESC)
  end

  def total_servings
    recipes.pluck(:servings).reduce(:+)
  end

  def total_prep_time
    recipes.pluck(:prep_time).reduce(:+)
  end

  def total_cook_time
    recipes.pluck(:cook_time).reduce(:+)
  end

  def total_time
    total_prep_time + total_cook_time
  end

  def total_ingredients
    # Option 1: SQL is faster
    # Ingredient.select(:name).distinct
    #           .joins('INNER JOIN recipes ON recipes.id = ingredients.recipe_id')
    #           .joins('INNER JOIN meal_plan_recipes ON meal_plan_recipes.recipe_id = recipes.id')
    #           .joins('INNER JOIN meal_plans ON meal_plans.id = meal_plan_recipes.meal_plan_id')
    #           .where("meal_plan_id = #{id}").count

    # Option 2: Reuses code
    IngredientSet.build_set(self).count
  end

  def meals
    total_servings / people_served
  end
end
