# frozen_string_literal: true

class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: %i[show search edit update destroy]

  def index
    @shopping_lists = current_user.shopping_lists.search(field: 'name', terms: params[:search]).by_favorite.by_name
    @shopping_list = current_user.shopping_lists.new
  end

  def show
    authorize(@shopping_list)

    @shopping_list_item = @shopping_list.shopping_list_items.new(quantity: 1)
  end

  def search
    search_term = params[:search]
    @shopping_list_items = @shopping_list.search_results(search_term)
  end

  def new
    @shopping_list = current_user.shopping_lists.new
  end

  def create
    @shopping_list = current_user.shopping_lists.new(shopping_list_params)
    authorize(@shopping_list)

    if @shopping_list.save
      redirect_to shopping_list_url(@shopping_list)
    else
      render :new
    end
  end

  def edit
    authorize(@shopping_list)
  end

  def update
    authorize(@shopping_list)

    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_url(@shopping_list), notice: 'ShoppingList Updated'
    else
      render :edit
    end
  end

  def destroy
    list = ShoppingList.find(params[:id])
    authorize(list)

    if list.deletable?
      list.destroy
      redirect_to shopping_lists_url, success: 'ShoppingList Deleted'
    else
      redirect_to shopping_lists_url, alert: "#{list.name} is not deletable"
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
