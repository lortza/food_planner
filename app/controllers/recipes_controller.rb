# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    user_recipes = current_user.recipes
    search_term = params[:search]

    @recipes = if search_term
                 user_recipes.search(search_term).by_title
               else
                 user_recipes.active.by_title
               end
  end

  def show
  end

  def new
    @recipe = current_user.recipes.new
    15.times { @recipe.ingredients.build(quantity: nil) }
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipe_url(@recipe)
    else
      render :new
    end
  end

  def edit
    # @recipe.ingredients.build(quantity: nil)
    3.times { @recipe.ingredients.build(quantity: nil) }
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
    flash[:success] = 'Recipe deleted'
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params # rubocop:disable Metrics/MethodLength
    params.require(:recipe).permit(:archived,
                                   :cook_time,
                                   :extra_work_note,
                                   :image_url,
                                   :instructions,
                                   :notes,
                                   :pepperplate_url,
                                   :prep_day_instructions,
                                   :prep_time,
                                   :reheat_instructions,
                                   :reheat_time,
                                   :servings,
                                   :source_name,
                                   :source_url,
                                   :title,
                                   ingredients_attributes: %i[
                                     id
                                     name
                                     quantity
                                     measurement_unit
                                     preparation_style
                                     _destroy
                                   ])
  end
end
