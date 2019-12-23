# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    user_recipes = current_user.recipes
    search_term = params[:search]
    recipes = search_term.present? ? user_recipes.search(field: 'title', terms: search_term) : user_recipes.active

    @recipes = recipes.by_title.paginate(page: params[:page], per_page: 30)
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

  def convert_from_experimental
    converted_title = params[:title]
    converted_url = params[:url]
    converted_source = URI.parse(converted_url).host.gsub('www.', '')

    @recipe = Recipe.new(
      title: converted_title,
      source_name: converted_source,
      source_url: converted_url
    )
    15.times { @recipe.ingredients.build(quantity: nil) }

    render "new"
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
