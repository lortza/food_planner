# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.by_title
  end

  def temp_tiles
    # randomly generated temporaty placeholder recipes
    @recipes = Recipe.by_title
    @prep_plan_recipes = Recipe.all.sample(5)
  end

  def show
  end

  def new
    @recipe = Recipe.new(Recipe::DEFAULT_PARAMS)
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
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe), notice: 'Recipe Updated'
    else
      render :edit
    end
  end

  def destroy
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
                                   :prep_time,
                                   :cook_time,
                                   :instructions)
  end
end
