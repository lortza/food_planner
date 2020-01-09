# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealPlansHelper, type: :helper do
  describe 'display_recipes' do
    it 'displays all recipes titles as links in a concatenated list joined by commas' do
      meal_plan = create(:meal_plan)
      recipe1 = create(:recipe, title: 'RecipeTitle1')
      recipe2 = create(:recipe, title: 'RecipeTitle2')
      meal_plan.recipes << [recipe1, recipe2]

      expect(display_recipes(meal_plan)).to eq("<a href=\"/recipes/#{recipe1.id}\">RecipeTitle1</a>, <a href=\"/recipes/#{recipe2.id}\">RecipeTitle2</a>")
    end
  end
end
