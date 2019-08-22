# frozen_string_literal: true

class ShoppingListItemManagersController < ApplicationController
  def create
    shopping_list = ShoppingList.find(permitted_params[:shopping_list_id])
    meal_plan = MealPlan.find(permitted_params[:meal_plan_id])
    ingredient = Ingredient.where(id: permitted_params[:ingredient_id])

    ShoppingListItemManager.new(
      shopping_list: shopping_list,
      ingredients: ingredient || meal_plan.ingredients
    ).add_items_to_list

    redirect_to shopping_list_url(shopping_list)
  end

  private

  def permitted_params
    params.permit(:shopping_list_id,
                  :meal_plan_id,
                  :ingredient_id)
  end
end
