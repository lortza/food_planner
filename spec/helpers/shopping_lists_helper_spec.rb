# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingListsHelper, type: :helper do
  describe 'toggle_favorite' do
    it 'when a list is favorited, it links to unfavorite' do
      list = create(:shopping_list, favorite: true)
      output = toggle_favorite(list)
      http_destroy_verb = 'delete'

      expect(output).to include(http_destroy_verb)
    end

    it 'when a list is not favorited, it links to favorite' do
      list = create(:shopping_list, favorite: false)
      output = toggle_favorite(list)
      http_create_verb = 'post'

      expect(output).to include(http_create_verb)
    end
  end

  describe 'display_quantity' do
    it 'displays the integerized number in parentheses if the value is greater than 1' do
      shopping_list_item = build(:shopping_list_item, quantity: 2.0)
      expect(display_quantity(shopping_list_item)).to eq('(2)')
    end

    it 'displays nothing if the value is 1' do
      shopping_list_item = build(:shopping_list_item, quantity: 1)
      expect(display_quantity(shopping_list_item)).to eq(nil)
    end

    it 'displays nothing if the value is == 1' do
      shopping_list_item = build(:shopping_list_item, quantity: 1)
      expect(display_quantity(shopping_list_item)).to eq(nil)
    end
  end
end
