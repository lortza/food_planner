# frozen_string_literal: true

class IngredientsController < ApplicationController
  def new
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:recipe_id, :quantity, :measurement_unit, :name, :preparation_style)
  end
end
