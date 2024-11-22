# frozen_string_literal: true

require "rails_helper"

RSpec.describe IngredientsHelper, type: :helper do
  describe "ingredient_display" do
    it "displays an ingredient's qty unit and name" do
      ingredient = build(:ingredient,
        measurement_unit: "cup",
        quantity: 1,
        name: "water")
      expected_output = "1 cup water"
      expect(helper.ingredient_display(ingredient)).to eq(expected_output)
    end

    it "pluralizes the unit when it is a standard unit" do
      ingredient = build(:ingredient,
        measurement_unit: "cup",
        quantity: 2,
        name: "water")
      expected_output = "2 cups water"
      expect(helper.ingredient_display(ingredient)).to eq(expected_output)
    end

    it "pluralizes the name when the unit is a descriptive unit" do
      ingredient = build(:ingredient,
        measurement_unit: "whole",
        quantity: 2,
        name: "carrot")
      expected_output = "2 whole carrots"
      expect(helper.ingredient_display(ingredient)).to eq(expected_output)
    end

    it "if present, displays the preparation_style" do
      ingredient = build(:ingredient,
        preparation_style: "minced",
        measurement_unit: "clove",
        quantity: 3,
        name: "garlic")
      expected_output = "3 cloves garlic: minced"
      expect(helper.ingredient_display(ingredient)).to eq(expected_output)
    end
  end

  describe "detail_display" do
    let(:recipe) { create(:recipe) }

    it "displays an ingredient's qty and unit" do
      ingredient = build(
        :ingredient,
        quantity: 1,
        measurement_unit: "cup",
        recipe: recipe
      )
      expected_output = "1 cup"
      expect(helper.detail_display(ingredient)).to eq(expected_output)
    end

    it "includes prep style when present" do
      ingredient = build(
        :ingredient,
        name: "tomato",
        quantity: 1,
        measurement_unit: "cup",
        preparation_style: "diced",
        recipe: recipe
      )
      expected_output = "1 cup diced"
      expect(helper.detail_display(ingredient)).to eq(expected_output)
    end

    describe "pluralization" do
      it "pluralizes the unit when it is a standard unit" do
        ingredient = build(
          :ingredient,
          measurement_unit: "cup",
          quantity: 2,
          recipe: recipe
        )
        expected_output = "2 cups"
        expect(helper.detail_display(ingredient)).to eq(expected_output)
      end

      it "does not pluralizes the unit when the unit is a descriptive unit" do
        ingredient = build(
          :ingredient,
          measurement_unit: "whole",
          quantity: 2,
          recipe: recipe
        )
        expected_output = "2 whole"
        expect(helper.detail_display(ingredient)).to eq(expected_output)
      end
    end
  end

  describe "qty_display" do
    it "displays whole numbers as integers" do
      ingredient = build(:ingredient, quantity: 1)
      expect(helper.qty_display(ingredient)).to eq(1)
    end

    it "displays known fractions as fractions" do
      ingredient = build(:ingredient, quantity: 0.125)
      expect(helper.qty_display(ingredient)).to eq("1/8")
    end

    it "handles 1/3 gracefully" do
      ingredient = build(:ingredient, quantity: 0.3)
      expect(helper.qty_display(ingredient)).to eq("1/3")
    end

    it "handles 1/6 gracefully" do
      ingredient = build(:ingredient, quantity: 0.6)
      expect(helper.qty_display(ingredient)).to eq("2/3")
    end

    it "rounds other unknown floats to 3 places" do
      ingredient = build(:ingredient, quantity: 0.711765)
      expect(helper.qty_display(ingredient)).to eq(0.712)
    end
  end
end
