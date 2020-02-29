# frozen_string_literal: true

class ShoppingListItemBuildersController < ApplicationController
  def create
    builder = ShoppingListItemBuilder.new(
      shopping_list_id: permitted_params[:shopping_list_id],
      # ingredient_ids: permitted_params[:ingredient_ids]
      ingredient_ids: permitted_params[:ingredientids].split(' ').map(&:to_i)
    )
    builder.add_items_to_list

    flash[:success] = "#{ActionController::Base.helpers.pluralize(builder.ingredients.count, 'item')} added."

    redirect_back(fallback_location: root_path)
  end

  private

  def permitted_params
    params.permit(:shopping_list_id, :ingredientids, ingredient_ids: [])
  end
end
