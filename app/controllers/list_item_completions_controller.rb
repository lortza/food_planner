# frozen_string_literal: true

class ListItemCompletionsController < ApplicationController
  before_action :set_shopping_list_item, only: %i[create destroy]

  def create
    @shopping_list_item.mark_as_complete!
    redirect_to shopping_list_url(@shopping_list_item.shopping_list)
  end

  def destroy
    @shopping_list_item.mark_as_uncomplete!
    redirect_to shopping_list_url(@shopping_list_item.shopping_list)
  end

  private

  def set_shopping_list_item
    @shopping_list_item = ShoppingListItem.find(params[:id])
  end

  def shopping_list_item_params
    params.require(:shopping_list_item)
          .permit(:shopping_list_id,
                  :aisle_id,
                  :quantity,
                  :name,
                  :purchased)
  end
end
