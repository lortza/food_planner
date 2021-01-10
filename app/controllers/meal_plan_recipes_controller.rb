# frozen_string_literal: true

class MealPlanRecipesController < ApplicationController
  before_action :set_recipe, only: :create
  before_action :set_meal_plan, only: :create
  def create
    meal_plan_recipe = MealPlanRecipe.new(meal_plan: @meal_plan, recipe: @recipe)

    if meal_plan_recipe.save
      redirect_back(
        fallback_location: recipes_url,
        notice: "#{@recipe.title} added to #{@meal_plan.prepared_on.to_s(:short)} meal plan"
      )
    else
      flash[:error] = "#{@recipe.title} was already part of the #{@meal_plan.prepared_on.to_s(:short)} meal plan."
      redirect_back(fallback_location: recipes_url)
    end
  end

  private

  def set_meal_plan
    meal_plan_id = meal_plan_params[:meal_plan_id] || meal_plan_recipe_params[:meal_plan_id]
    @meal_plan = current_user.meal_plans.find_by(id: meal_plan_id)
  end

  def set_recipe
    @recipe = current_user.recipes.find_by(id: recipe_params[:recipe_id])
  end

  def recipe_params
    params.permit(:recipe_id)
  end

  def meal_plan_params
    params.permit(:meal_plan_id)
  end

  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(:meal_plan_id, :recipe_id)
  end
end
