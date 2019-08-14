# frozen_string_literal: true

class ShoppingListFavoritesController < ApplicationController
  before_action :set_shopping_list, only: %i[create destroy]

  def create
    user = @shopping_list.user
    user.shopping_lists.each(&:unfavorite!)

    @shopping_list.favorite!
    redirect_to shopping_lists_url
  end

  def destroy
    @shopping_list.unfavorite!
    redirect_to shopping_lists_url
  end

  private

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list)
          .permit(:user_id,
                  :name,
                  :favorite)
  end
end
