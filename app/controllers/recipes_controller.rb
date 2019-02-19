# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).by_title
    else
      @recipes = Recipe.by_title
    end
  end

  def show
  end

  def new
    @recipe = Recipe.new
    15.times { @recipe.ingredients.build({quantity: nil}) }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe_url(@recipe)
    else
      render :new
    end
  end

  def edit
    # @recipe.ingredients.build({quantity: nil})
    3.times { @recipe.ingredients.build({quantity: nil}) }
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe), notice: 'Recipe Updated'
    else
      render :edit
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted"
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title,
                                   :servings,
                                   :source_name,
                                   :source_url,
                                   :pepperplate_url,
                                   :image_url,
                                   :prep_time,
                                   :cook_time,
                                   :reheat_time,
                                   :instructions,
                                   :notes,
                                   { ingredients_attributes: [
                                     :id,
                                     :name,
                                     :quantity,
                                     :measurement_unit,
                                     :preparation_style,
                                     :_destroy
                                   ] }
                                  )
  end
end
