# frozen_string_literal: true

class PendingRecipesController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = current_user.recipes.new(status: :pending)
    authorize(@recipe)
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    authorize(@recipe)

    extracted_uri = URI.extract(@recipe.source_url)[0]
    @recipe.source_url = extracted_uri if extracted_uri.present?
    @recipe.source_name = URI.parse(@recipe.source_url).host.gsub("www.", "")

    extracted_content = RecipeDataExtractor.extract_from_site(@recipe.source_url)
    @recipe = RecipeDataExtractor.format_data(recipe: @recipe, extracted_data: extracted_content)

    if @recipe.save
      redirect_to recipes_url(@recipe), notice: "Pending recipe created."
    else
      render :new
    end
  end

  private

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
