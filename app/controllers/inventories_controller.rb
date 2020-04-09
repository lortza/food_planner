# frozen_string_literal: true

class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update]

  def edit
    authorize(@inventory)
  end

  def update
    authorize(@inventory)

    if @inventory.update(inventory_params)
      redirect_to inventory_recipe_suggestions_path(@inventory)
    else
      render :edit
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:user_id, :items)
  end
end
