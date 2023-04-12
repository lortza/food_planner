# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_recipe, only: %i[show edit update destroy copy_for_user]

  def index
    recipes = policy_scope(Recipe)
    search_term = params[:search]
    recipes = search_term.present? ? recipes.search(field: 'title', terms: search_term) : recipes.active

    @recipes = recipes.includes(:meal_plans, :meal_plan_recipes)
                      .order(updated_at: 'DESC')
                      .paginate(page: params[:page], per_page: 30)
  end

  def show
    fail
  end

  def new
    @recipe = current_user.recipes.new
    15.times { @recipe.ingredients.build(quantity: nil) }

    authorize(@recipe)
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize(@recipe)

    if @recipe.save
      experimental_recipe_id = recipe_params[:experimental_recipe_id]

      current_user.experimental_recipes.find(experimental_recipe_id).delete if experimental_recipe_id.present?

      redirect_to recipe_url(@recipe), alert: ('Recipe converted successfully.' if experimental_recipe_id.present?)
    else
      render :new
    end
  end

  def edit
    authorize(@recipe)

    3.times { @recipe.ingredients.build(quantity: nil) }
  end

  def update
    authorize(@recipe)

    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe), notice: 'Recipe Updated'
    else
      render :edit
    end
  end

  def destroy
    authorize(@recipe)

    @recipe.destroy
    flash[:success] = 'Recipe deleted'
    redirect_to recipes_path
  end

  def convert_from_experimental
    experimental_recipe = current_user.experimental_recipes.find(params[:experimental_recipe_id])
    @recipe = current_user.recipes.new(
      title: experimental_recipe.title,
      source_name: URI.parse(experimental_recipe.source_url).host.gsub('www.', ''),
      source_url: experimental_recipe.source_url,
      experimental_recipe_id: experimental_recipe.id
    )
    15.times { @recipe.ingredients.build(quantity: nil) }

    render :new
  end

  def copy_for_user
    user = User.find_by(email: params[:email])

    if user.present? && user == current_user
      flash[:error] = "Whoops! You can't duplicate your own recipe."
      redirect_to recipe_url(@recipe)
    elsif user.present?
      @recipe.dupe_for_user(user)
      redirect_to recipe_url(@recipe), notice: "#{@recipe.title} copied for #{user.email}"
    else
      flash[:error] = "Sorry! We couldn't find a user with the email address '#{params[:email]}'."
      redirect_to recipe_url(@recipe)
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params # rubocop:disable Metrics/MethodLength
    params.require(:recipe).permit(:archived,
                                   :cook_time,
                                   :experimental_recipe_id,
                                   :extra_work_note,
                                   :image_url,
                                   :instructions,
                                   :notes,
                                   :nutrition_data_iframe,
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
