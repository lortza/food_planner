# frozen_string_literal: true

class ExperimentalRecipesController < ApplicationController
  before_action :set_experimental_recipe, only: %i[edit update destroy]

  def index
    @experimental_recipes = current_user.experimental_recipes.by_title
  end

  def new
    @experimental_recipe = current_user.experimental_recipes.new
  end

  def edit
  end

  def create
    @experimental_recipe = current_user.experimental_recipes.new(experimental_recipe_params)

    if @experimental_recipe.save
      redirect_to experimental_recipes_url, notice: 'Experimental recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    if @experimental_recipe.update(experimental_recipe_params)
      redirect_to experimental_recipes_url, notice: 'Recipe link was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @experimental_recipe.destroy
    redirect_to experimental_recipes_url, notice: 'Recipe link was successfully destroyed.'
  end

  private

  def set_experimental_recipe
    @experimental_recipe = current_user.experimental_recipes.find(params[:id])
  end

  def experimental_recipe_params
    params.require(:experimental_recipe).permit(:title, :source_url, :user_id)
  end
end
