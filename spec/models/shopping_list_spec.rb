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

  describe 'self.default' do
    let(:user) { create(:user) }
    let(:shopping_list) { create(:shopping_list, user: user) }

    it 'returns the existing shopping list called "grocery" that belongs to the current_user' do
      existing_list = create(:shopping_list, user: user, name: 'grocery', main: true)
      retured_list = ShoppingList.default(user)

      expect(retured_list).to eq(existing_list)
    end

    it 'creates a new list called "grocery" for the user if one does not exist' do
      retured_list = ShoppingList.default(user)
      expect(retured_list.name).to eq('grocery')
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

  describe 'deletable?' do
    it 'returns false if it is the "main" list' do
      list = build(:shopping_list, main: true)
      expect(list.deletable?).to be(false)
    end

    it 'returns false if it is the "weekly" list' do
      list = build(:shopping_list, weekly: true)
      expect(list.deletable?).to be(false)
    end

    it 'returns false if it is the "monthly" list' do
      list = build(:shopping_list, monthly: true)
      expect(list.deletable?).to be(false)
    end

    it 'returns true if it is any other list' do
      list = build(:shopping_list)
      expect(list.deletable?).to be(true)
    end
  end
end
