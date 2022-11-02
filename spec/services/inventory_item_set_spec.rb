# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryItemSet, type: :service do
  let(:user) { create(:user) }

  before do
    recipe1 = create(:recipe, user: user)
    create(:ingredient, recipe: recipe1, name: '1 cup water')
    create(:ingredient, recipe: recipe1, name: '1 cup rice')

    recipe2 = create(:recipe, user: user)
    create(:ingredient, recipe: recipe2, name: '2 tablespoon water')
    create(:ingredient, recipe: recipe2, name: '.5 cup beans')
  end

  describe '#suggest' do
    it 'strips duplicates from the list' do
      items = "water\r\n\r\nrice\r\n\r\nwater\r\n\r\nwater"
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions.keys).to eq(%w[water rice])
    end

    xit 'can handle inventory items ending in s' do
      items = 'waters'
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions.keys).to eq(%w[water])
    end

    it 'removes blanks from the list' do
      items = "water\r\n\r\n   rice\r\n\r\nwater\r\n\r\nbeans  \r\n\r\n"
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions.keys).to_not include('')
      expect(suggestions.keys).to eq(%w[water rice beans])
    end

    it 'returns each item with an array of recipes' do
      items = "water\r\n\r\nrice\r\n\r\nwater\r\n\r\nbeans"
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions['beans'].count).to eq(1)
      expect(suggestions['rice'].count).to eq(1)
      expect(suggestions['water'].count).to eq(2)
    end

    it 'returns the list of items as keys' do
      items = "water\r\n\r\nrice\r\n\r\n"
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions.keys).to eq(%w[water rice])
    end

    it 'returns an [] for items without recipe matches' do
      items = 'not an ingredient'
      inventory = create(:inventory, user: user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions['not an ingredient']).to eq([])
    end

    it 'only returns recipes for the given user' do
      original_user = create(:user)
      recipe1 = create(:recipe, user: original_user)
      create(:ingredient, recipe: recipe1, name: '1 cup rice')

      different_user = create(:user)
      recipe3 = create(:recipe, user: different_user)
      create(:ingredient, recipe: recipe3, name: '.5 cup beans')

      items = "beans\r\n\r\nrice"
      inventory = create(:inventory, user: original_user, items: items)
      suggestions = InventoryItemSet.new(inventory).suggest_recipes

      expect(suggestions['rice'].count).to eq(1)
      expect(suggestions['beans'].count).to eq(0)
    end
  end
end
