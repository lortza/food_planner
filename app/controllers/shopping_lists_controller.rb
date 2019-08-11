# frozen_string_literal: true

class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: %i[show edit update destroy]

  def index
    @shopping_lists = current_user.shopping_lists.search(params[:search]).by_favorite.by_name
    @shopping_list = current_user.shopping_lists.new
  end

  def show
    @shopping_list_item = @shopping_list.shopping_list_items.new(quantity: 1)
  end

  def create
    @shopping_list = current_user.shopping_lists.new(shopping_list_params)
    if @shopping_list.save
      redirect_to shopping_list_url(@shopping_list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_url(@shopping_list), notice: 'ShoppingList Updated'
    else
      render :edit
    end
  end

  def destroy
    ShoppingList.find(params[:id]).destroy
    flash[:success] = 'ShoppingList deleted'
    redirect_to shopping_lists_path
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
