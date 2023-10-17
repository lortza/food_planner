# frozen_string_literal: true

class ShoppingListItemStatusesController < ApplicationController
  before_action :set_shopping_list_item, except: %i[deactivate_all]

  def activate
    # makes a crossed off item active again
    if @shopping_list_item.in_cart?
      @shopping_list_item.add_to_cart!
    else
      @shopping_list_item.activate!
    end
    respond_to :js
  end

  def activate_from_search
    @shopping_list_item.activate! unless @shopping_list_item.in_cart?
    respond_to :js
  end

  def deactivate
    # crosses an item off of the list
    @shopping_list_item.deactivate!
    respond_to :js
  end

  def add_to_cart
    # Marks item as part of delivery
    @shopping_list_item.add_to_cart!
    respond_to :js
  end

  def remove_from_cart
    # Removes part-of-delivery marking from item
    @shopping_list_item.remove_from_cart!
    respond_to :js
  end

  def deactivate_all
    # crosses all items on the list
    list = current_user.shopping_lists.find(params[:id])
    list.items.map(&:deactivate!)
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
                  :heb_upc,
                  :name,
                  :quantity,
                  :status)
  end
end
