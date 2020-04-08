# frozen_string_literal: true

class RecipeSuggestionsController < ApplicationController
  def index
    @inventory = Inventory.find_by(id: params[:inventory_id])
    @suggestions = RecipeSuggestion.new(@inventory).suggest
  end
end
