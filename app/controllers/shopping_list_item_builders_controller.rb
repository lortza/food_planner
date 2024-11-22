# frozen_string_literal: true

class ShoppingListItemBuildersController < ApplicationController
  before_action :set_shopping_list, only: %i[create]

  def create
    ingredient_ids = permitted_params[:ingredient_ids].split.map(&:to_i)
    ShoppingListItemBuilder.add_ingredients_to_list(shopping_list: @shopping_list, ingredient_ids: ingredient_ids)

    flash[:notice] = flash_message(ingredient_ids)
    redirect_back(fallback_location: root_path)
  end

  private

  def flash_message(ingredient_ids)
    pluralized_ingredients = ActionController::Base.helpers.pluralize(ingredient_ids.length, "item")
    link = ActionController::Base.helpers.link_to(@shopping_list.name.titleize, shopping_list_path(@shopping_list))

    "#{pluralized_ingredients} added to your #{link} list."
  end

  def set_shopping_list
    @shopping_list = ShoppingList.find_by(id: permitted_params[:shopping_list_id])
  end

  def permitted_params
    params.permit(:shopping_list_id, :ingredient_ids)
  end
end
