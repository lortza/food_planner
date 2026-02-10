# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_recipe, only: %i[show edit update destroy copy_for_user]

  def index
    recipes = policy_scope(Recipe)
    search_term = params[:search]&.strip&.squish

    recipes = search_term.present? ? recipes.search(field: "title", terms: search_term) : recipes.active_or_pending

    @recipes = recipes.includes(:meal_plans, :meal_plan_recipes)
      .order(updated_at: "DESC")
      .paginate(page: params[:page], per_page: 30)
  end

  def show
    @recipe.calculate_nutrition! 
    # @recipe.calculate_nutrition! if @recipe.nutrition_profile.blank?
  end

  def new
    @recipe = current_user.recipes.new
    authorize(@recipe)

    15.times { @recipe.ingredients.build(quantity: nil) }
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize(@recipe)

    if @recipe.save
      redirect_to recipe_url(@recipe), notice: "Recipe created." and return
    else
      render :new
    end
  end

  def edit
    authorize(@recipe)

    ingredient_qty = @recipe.ingredients.any? ? 3 : 15
    ingredient_qty.times { @recipe.ingredients.build(quantity: nil) }
  end

  #   def update
  #     authorize(@recipe)
  #     if @recipe.update(recipe_params)
  #       redirect_to recipe_url(@recipe), notice: "Recipe Updated"
  #     else
  #       render :edit
  #     end
  #   end

  def update
    authorize(@recipe)

    # Snapshot before update
    old_ingredients_snapshot = @recipe.recipe_ingredients
      .pluck(:ingredient_id, :quantity, :unit)
      .sort

    if @recipe.update(recipe_params)
      # Snapshot after update
      new_ingredients_snapshot = @recipe.recipe_ingredients
        .reload
        .pluck(:ingredient_id, :quantity, :unit)
        .sort

      # Compare
      if (old_ingredients_snapshot != new_ingredients_snapshot) || @recipe.saved_change_to_attribute?(:servings)
        @recipe.calculate_nutrition!
      end

      redirect_to @recipe, notice: "Recipe updated!"
    else
      render :edit
    end
  end

  def destroy
    authorize(@recipe)

    @recipe.destroy
    flash[:success] = "Recipe deleted"
    redirect_to recipes_path
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

  def recipe_params
    params.require(:recipe).permit(
      :cook_time,
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
      :status,
      :title,
      ingredients_attributes: %i[
        id
        name
        quantity
        measurement_unit
        preparation_style
        _destroy
      ],
      tag_ids: []
    )
  end
end
