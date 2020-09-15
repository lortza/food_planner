# frozen_string_literal: true

class ShoppingListItemBuildersController < ApplicationController
  def create
    shopping_list = ShoppingList.find_by(id: permitted_params[:shopping_list_id])
    ingredient_ids = permitted_params[:ingredient_ids].split(' ').map(&:to_i)
    ShoppingListItemBuilder.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)

    list_name = shopping_list.name
    pluralized_ingredients = ActionController::Base.helpers.pluralize(ingredient_ids.length, 'item')
    link = ActionController::Base.helpers.link_to list_name.titleize, shopping_list_path(shopping_list)

    flash[:notice] = "#{pluralized_ingredients} added to your #{link} list."
    redirect_back(fallback_location: root_path)
  end

  private

  def permitted_params
    params.permit(:shopping_list_id, :ingredient_ids)
  end
end
