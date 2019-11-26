# frozen_string_literal: true

RSpec.describe ShoppingListItem, type: :model do
  let(:shopping_list_item) { build(:shopping_list_item) }

  context 'associations' do
    it { should belong_to(:aisle) }
    it { should belong_to(:shopping_list) }
    it { should belong_to(:list) }
  end

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
      create(:shopping_list_item)
      item2 = create(:shopping_list_item)
      create(:shopping_list_item)

      item2.purchased = true
      item2.save

      ordered_items = ShoppingListItem.by_recently_edited

      expect(ordered_items.first).to eq(item2)
    end
  end

  describe 'self.by_aisle_order_number' do
    it "orders based on the associated aisle's order_number" do
      first_aisle = create(:aisle, name: 'first aisle', order_number: 1)
      second_aisle = create(:aisle, name: 'second aisle', order_number: 2)

      list = create(:shopping_list, name: 'list')
      second_item = create(:shopping_list_item, shopping_list_id: list.id, aisle_id: second_aisle.id)
      first_item = create(:shopping_list_item, shopping_list_id: list.id, aisle_id: first_aisle.id)

      expect(list.shopping_list_items.by_aisle_order_number.first).to eq(first_item)
      expect(list.shopping_list_items.by_aisle_order_number.last).to eq(second_item)
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
