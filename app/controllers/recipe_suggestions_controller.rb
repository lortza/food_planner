# frozen_string_literal: true

class RecipeSuggestionsController < ApplicationController
  def index
    @inventory = Inventory.find_by(id: params[:inventory_id])
    inventory_item_set = InventoryItemSet.new(@inventory)
    authorize(inventory_item_set)

    @suggestions = inventory_item_set.suggest_recipes
  end
end
