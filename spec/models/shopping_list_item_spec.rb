# frozen_string_literal: true

RSpec.describe ShoppingListItem, type: :model do
  let(:shopping_list_item) { build(:shopping_list_item) }

  describe 'a valid shopping_list_item' do
    context 'when has valid params' do
      it 'is valid' do
        expect(shopping_list_item).to be_valid
      end

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:aisle_id) }
      it { should validate_presence_of(:shopping_list_id) }
    end
  end

  describe 'self.by_recently_edited' do
    it 'returns the most recently editied item first' do
      item1 = create(:shopping_list_item)
      item2 = create(:shopping_list_item)
      item3 = create(:shopping_list_item)
      item2.purchased = true
      item2.save

      ordered_items = ShoppingListItem.by_recently_edited

      expect(ordered_items.first).to eq(item2)
    end
  end

  describe '#complete!' do
    it 'sets the "purchased" attribute to true and saves the item' do
      item = create(:shopping_list_item, purchased: false)
      item.complete!

      expect(item.purchased).to eq(true)
    end
  end

  describe '#uncomplete!' do
    it 'sets the "purchased" attribute to false and saves the item' do
      item = create(:shopping_list_item, purchased: true)
      item.uncomplete!

      expect(item.purchased).to eq(false)
    end
  end
end
