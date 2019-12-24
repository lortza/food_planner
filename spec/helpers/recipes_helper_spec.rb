# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesHelper, type: :helper do
  describe 'guaranteed_image' do
    let(:recipe) { build(:recipe, image_url: '') }
    it 'ensures an image file is returned' do
      expect(helper.guaranteed_image(recipe)).to eq('recipe_placeholder.jpg')
    end
  end

  describe 'status_flag' do
    it 'returns "archived" when recipe is not active' do
      recipe = build(:recipe, archived: true)
      expect(helper.status_flag(recipe)).to eq('archived')
    end

    it 'returns "new" when recipe has no prep dates' do
      recipe = build(:recipe)
      recipe.meal_plan_recipes = []

      expect(helper.status_flag(recipe)).to include('assets/icon_')
    end

    it 'returns "been a while" when recipe has not been made in the past 4 months' do
      recipe = create(:recipe)
      four_months_ago = Time.zone.today - 5.months
      recipe.meal_plans << create(:meal_plan, start_date: four_months_ago)

      expect(helper.status_flag(recipe)).to include('assets/icon_')
    end

    it 'does not return a flag when recipe has no conditions' do
      recipe = create(:recipe)
      recipe.meal_plans << create(:meal_plan, start_date: Time.zone.today)

      expect(helper.status_flag(recipe)).to eq('')
    end
  end
end
