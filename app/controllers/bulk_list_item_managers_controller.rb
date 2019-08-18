# frozen_string_literal: true

class BulkListItemManagersController < ApplicationController
  def create
    shopping_list = ShoppingList.find(permitted_params[:shopping_list_id])
    meal_plan = MealPlan.find(permitted_params[:meal_plan_id])

    BulkListItemManager.new(
      shopping_list: shopping_list,
      items_source: meal_plan
    ).add_items_to_list

    redirect_to shopping_list_url(shopping_list)
  end

  private

  def permitted_params
    params.permit(:shopping_list_id,
                  :meal_plan_id)
  end
end
