# frozen_string_literal: true

class ShoppingListItemManagersController < ApplicationController
  def create
    shopping_list = ShoppingList.find(permitted_params[:shopping_list_id])
    meal_plan = MealPlan.find(permitted_params[:meal_plan_id])
    ingredient = Ingredient.where(id: permitted_params[:ingredient_id])

    manager = ShoppingListItemManager.new(
      shopping_list: shopping_list,
      ingredients: ingredient&.empty? ? meal_plan.ingredients : ingredient
    )
    manager.add_items_to_list

    flash[:success] = "#{ActionController::Base.helpers.pluralize(manager.ingredients.count, 'item')} added."
    redirect_to meal_plan
  end

  private

  def permitted_params
    params.permit(:shopping_list_id,
                  :meal_plan_id,
                  :ingredient_id)
  end
end
