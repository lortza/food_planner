# frozen_string_literal: true

class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: %i[show edit update destroy]

  def index
    @shopping_lists = if params[:search]
       current_user.shopping_lists.search(params[:search]).by_name
     else
       current_user.shopping_lists.by_name
     end
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
