# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExperimentalRecipe, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  describe "normalization" do
    it "strips leading/trailing whitespace and squishes internal whitespace in the title" do
      experimental_recipe = build(:experimental_recipe, title: "  Example    Recipe  ")
      expect(experimental_recipe.valid?).to be(true)
      expect(experimental_recipe.title).to eq("Example Recipe")
    end

    it "does not affect case of the title" do
      experimental_recipe = build(:experimental_recipe, title: "  ExAmPlE    ReCIPe  ")
      expect(experimental_recipe.valid?).to be(true)
      expect(experimental_recipe.title).to eq("ExAmPlE ReCIPe")
    end

    it "strips leading/trailing whitespace in the source_url" do
      experimental_recipe = build(:experimental_recipe, source_url: "  https://example.com/recipe  ")
      expect(experimental_recipe.valid?).to be(true)
      expect(experimental_recipe.source_url).to eq("https://example.com/recipe")
    end
  end

  describe "a valid recipe" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:source_url) }
  end
end
