# frozen_string_literal: true

class ShoppingListItemsController < ApplicationController
  before_action :set_shopping_list, only: %i[new create edit update destroy]
  before_action :set_shopping_list_item, only: %i[edit update destroy]

  def new
    @shopping_list_item = @shopping_list.items.new(quantity: 1, name: params[:search_term])
  end

  def create
    incoming_item = @shopping_list.items.new(shopping_list_item_params)
    existing_item = @shopping_list.items.find_by(name: incoming_item.name)

    if existing_item
      updated_quantity = existing_item.quantity + incoming_item.quantity
      updated_quantity = incoming_item.quantity if existing_item.purchased?
      existing_item.update(quantity: updated_quantity, purchased: false)
    else
      incoming_item.purchased = false
      @shopping_list.items << incoming_item
    end

    redirect_to shopping_list_url(@shopping_list)
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

  def destroy
    item = ShoppingListItem.find(params[:id]).destroy
    flash[:warning] = "#{item.name} was deleted."
    redirect_to shopping_list_url(@shopping_list)
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
                  :heb_upc,
                  :name,
                  :purchased,
                  :recurrence_frequency,
                  :recurrence_quantity)
  end
end
