# frozen_string_literal: true

class ShoppingListItemBuildersController < ApplicationController
  def create
    builder = ShoppingListItemBuilder.new(
      shopping_list_id: permitted_params[:shopping_list_id],
      ingredient_ids: permitted_params[:ingredient_ids].split(' ').map(&:to_i)
    )
    builder.add_items_to_list

    list_name = builder.shopping_list.name
    pluralized_ingredients = ActionController::Base.helpers.pluralize(builder.ingredients.count, 'item')
    flash[:success] = "#{pluralized_ingredients} added to #{list_name.titleize} List."

    redirect_back(fallback_location: root_path)
  end

  private

  def permitted_params
    params.permit(:shopping_list_id, :ingredient_ids)
  end
end
