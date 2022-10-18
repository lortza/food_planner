# frozen_string_literal: true

class AddNutritionDataIframeToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :nutrition_data_iframe, :text
  end
end
