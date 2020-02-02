# frozen_string_literal: true

class CompletedShoppingListItemsController < ApplicationController
  before_action :set_shopping_list_item, only: %i[create destroy]

  def create
    # crosses an item off of the list
    @shopping_list_item.complete!
    respond_to :js
  end

  def destroy
    # makes a crossed off item active again
    @shopping_list_item.uncomplete!
    respond_to :js
  end

  def deactivate_all
    # crosses all items on the list
    list = current_user.shopping_lists.find(params[:id])
    list.items.map(&:complete!)
    redirect_to shopping_list_url(list)
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
                  :heb_upc,
                  :name,
                  :purchased)
  end
end
