# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecipesHelper, type: :helper do
  describe "guaranteed_image" do
    let(:recipe) { build(:recipe, image_url: "") }
    it "ensures an image file is returned" do
      expect(helper.guaranteed_image(recipe)).to eq("recipe_placeholder.jpg")
    end
  end

  describe "status_flag" do
    it 'returns "archived" when recipe is not active' do
      recipe = build(:recipe, archived: true)
      expect(helper.status_flag(recipe)).to include("Archived")
    end

    it 'returns "new" when recipe has no prep dates' do
      recipe = build(:recipe)
      recipe.meal_plan_recipes = []

      expect(helper.status_flag(recipe)).to include("new_releases")
    end

    it 'returns "new" when recipe has no prep dates before today' do
      recipe = build(:recipe)
      recipe.meal_plans << create(:meal_plan, prepared_on: Time.zone.today)

      expect(helper.status_flag(recipe)).to include("new_releases")
    end

    it 'returns "been a while" when recipe has not been made in the past 4 months' do
      recipe = create(:recipe)
      four_months_ago = Time.zone.today - 5.months
      recipe.meal_plans << create(:meal_plan, prepared_on: four_months_ago)

      expect(helper.status_flag(recipe)).to include("calendar_clock")
    end

    it "does not return a flag when recipe was made recently" do
      recipe = create(:recipe)
      four_days_ago = Time.zone.today - 4.days
      recipe.meal_plans << create(:meal_plan, prepared_on: four_days_ago)

      expect(helper.status_flag(recipe)).to eq("")
    end
  end

  describe "recipe_ingredient_ids" do
    it "returns an array of ingredient ids from this recipe" do
      recipe = create(:recipe, :with_2_ingredients)

      expect(helper.recipe_ingredient_ids(recipe)).to be_a(Array)
      expect(helper.recipe_ingredient_ids(recipe).length).to eq(2)
    end

    it "returns only ids for this recipe's ingredients" do
      recipe1 = create(:recipe, :with_2_ingredients)
      recipe2 = create(:recipe, :with_2_ingredients)

      recipe1_results = recipe1.ingredients.pluck(:id)
      expect(helper.recipe_ingredient_ids(recipe1)).to eq(recipe1_results)

      recipe2_results = recipe2.ingredients.pluck(:id)
      expect(helper.recipe_ingredient_ids(recipe1)).to_not eq(recipe2_results)
    end
  end
end
