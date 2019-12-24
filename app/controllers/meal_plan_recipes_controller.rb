# frozen_string_literal: true

class MealPlanRecipesController < ApplicationController
  def create
    meal_plan_id = params[:meal_plan_id] || params[:meal_plan_recipe][:meal_plan_id]
    meal_plan = current_user.meal_plans.find_by(id: meal_plan_id)
    recipe = current_user.recipes.find_by(id: params[:recipe_id])
    meal_plan_recipe = MealPlanRecipe.new(meal_plan: meal_plan, recipe: recipe)

    if meal_plan_recipe.save
      redirect_back(fallback_location: recipes_url,
                    notice: "#{recipe.title} added to #{meal_plan.start_date.to_s(:short)} meal plan")
    else
      flash[:error] = "#{recipe.title} was already part of the #{meal_plan.start_date.to_s(:short)} meal plan."
      redirect_back(fallback_location: recipes_url)
    end
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:meal_plan_id, :recipe_id)
  end
end
