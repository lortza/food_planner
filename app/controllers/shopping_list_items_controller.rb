# frozen_string_literal: true

class ShoppingListItemsController < ApplicationController
  before_action :set_shopping_list, only: %i[new create edit update destroy]
  before_action :set_shopping_list_item, only: %i[edit update destroy]

  def new
    @shopping_list_item = @shopping_list.items.new(quantity: 1)
  end

  def create
    @shopping_list_item = @shopping_list.items.new(shopping_list_item_params)
    if @shopping_list_item.save
      redirect_to shopping_list_url(@shopping_list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shopping_list_item.update(shopping_list_item_params)
      redirect_to shopping_list_url(@shopping_list)
    else
      render :edit
    end
  end

  private

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

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
