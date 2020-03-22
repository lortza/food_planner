# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientsHelper, type: :helper do
  describe 'ingredient_display' do
    it "displays an ingredient's qty unit and name" do
      ingredient = build(:ingredient, preparation_style: nil)
      display_output = "#{ingredient.quantity} #{ingredient.measurement_unit} #{ingredient.name}"
      expect(helper.ingredient_display(ingredient)).to eq(display_output)
    end

    it "if present, displays the preparation_style" do
      ingredient = build(:ingredient, preparation_style: 'styled')
      display_output = "#{ingredient.quantity} #{ingredient.measurement_unit} #{ingredient.name}: #{ingredient.preparation_style}"
      expect(helper.ingredient_display(ingredient)).to eq(display_output)
    end
  end

  describe 'detail_display' do
    it "displays an ingredient's qty, unit, prep style, and recipe" do
      recipe = create(:recipe)
      ingredient = build(:ingredient, quantity: 1, measurement_unit: 'cup', preparation_style: 'dry', recipe: recipe)
      display_output = "<a href=\"/recipes/#{recipe.id}\">1 cup dry (#{recipe.title})</a>"

      expect(helper.detail_display(ingredient)).to eq(display_output)
    end
  end

  describe 'qty_display' do
    it 'displays whole numbers as integers' do
      ingredient = build(:ingredient, quantity: 1)
      expect(helper.qty_display(ingredient)).to eq(1)
    end

    it 'displays known fractions as fractions' do
      ingredient = build(:ingredient, quantity: 0.125)
      expect(helper.qty_display(ingredient)).to eq('1/8')
    end

    it 'handles 1/3 gracefully' do
      ingredient = build(:ingredient, quantity: 0.3)
      expect(helper.qty_display(ingredient)).to eq('1/3')
    end

    it 'handles 1/6 gracefully' do
      ingredient = build(:ingredient, quantity: 0.6)
      expect(helper.qty_display(ingredient)).to eq('2/3')
    end

    it 'rounds other unknown floats to 3 places' do
      ingredient = build(:ingredient, quantity: 0.711765)
      expect(helper.qty_display(ingredient)).to eq(0.712)
    end
  end
end
