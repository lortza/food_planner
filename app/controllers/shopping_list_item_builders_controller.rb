# frozen_string_literal: true

class ShoppingListItemBuildersController < ApplicationController
  def create
    builder = ShoppingListItemBuilder.new(
      shopping_list: ShoppingList.find(permitted_params[:shopping_list_id]),
      single_ingredient: Ingredient.where(id: permitted_params[:ingredient_id]),
      meal_plan: MealPlan.find(permitted_params[:meal_plan_id]),
    )
    builder.add_items_to_list

    flash[:success] = "#{ActionController::Base.helpers.pluralize(builder.ingredients.count, 'item')} added."
    redirect_to builder.meal_plan
  end

  private

  def permitted_params
    params.permit(:shopping_list_id,
                  :meal_plan_id,
                  :ingredient_id)
  end
end
