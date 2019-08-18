# frozen_string_literal: true

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { build(:shopping_list) }

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:shopping_list_items) }
    it { should have_many(:items) }
  end

  describe 'a valid shopping_list' do
    context 'when has valid params' do
      it 'is valid' do
        expect(shopping_list).to be_valid
      end

      it { should validate_presence_of(:name) }
    end
  end

  describe '.by_favorite' do
    it 'returns results with the favorite first' do
      favorite_list = create(:shopping_list, favorite: true)
      create(:shopping_list, favorite: false)
      ordered_lists = ShoppingList.by_favorite

      expect(ordered_lists.first).to eq(favorite_list)
    end
  end

  describe '#favorite!' do
    it 'sets the "favorite" attribute to true and saves the list' do
      list = create(:shopping_list, favorite: false)
      list.favorite!

      expect(list.favorite).to eq(true)
    end
  end

  describe '#unfavorite!' do
    it 'sets the "favorite" attribute to false and saves the list' do
      list = create(:shopping_list, favorite: true)
      list.unfavorite!

      expect(list.favorite).to eq(false)
    end
  end
end
