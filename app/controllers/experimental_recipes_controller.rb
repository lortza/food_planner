# frozen_string_literal: true

class ExperimentalRecipesController < ApplicationController
  before_action :set_experimental_recipe, only: %i[edit update destroy]

  def index
    @experimental_recipes = policy_scope(ExperimentalRecipe).by_title
  end

  def new
    @experimental_recipe = current_user.experimental_recipes.new
    authorize(@experimental_recipe)
  end

  def edit
    authorize(@experimental_recipe)
  end

  def create
    @experimental_recipe = current_user.experimental_recipes.new(experimental_recipe_params)
    authorize(@experimental_recipe)

    if @experimental_recipe.save
      redirect_to experimental_recipes_url, notice: 'Experimental recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize(@experimental_recipe)

    if @experimental_recipe.update(experimental_recipe_params)
      redirect_to experimental_recipes_url, notice: 'Recipe link was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize(@experimental_recipe)

    @experimental_recipe.destroy
    redirect_to experimental_recipes_url, notice: 'Recipe link was successfully destroyed.'
  end

  private

  def set_experimental_recipe
    @experimental_recipe = ExperimentalRecipe.find(params[:id])
  end

  def experimental_recipe_params
    params.require(:experimental_recipe).permit(:title, :source_url, :user_id)
  end
end
