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
      it { should validate_presence_of(:status) }
      it { should validate_inclusion_of(:status).in_array(ShoppingListItem::STATUSES) }
    end
  end

  context 'scopes' do
    let(:active_item) { create(:shopping_list_item, status: 'active') }
    let(:inactive_item) { create(:shopping_list_item, status: 'inactive') }
    let(:in_cart_item) { create(:shopping_list_item, status: 'in_cart') }

    before do
      active_item
      inactive_item
      in_cart_item
    end

    describe 'active' do
      it 'returns only active items' do
        expect(described_class.active).to include(active_item)
      end

      it 'does not return items without the status of active' do
        expect(described_class.active).to_not include(inactive_item)
        expect(described_class.active).to_not include(in_cart_item)
      end
    end

    describe 'inactive' do
      it 'returns only inactive items' do
        expect(described_class.inactive).to include(inactive_item)
      end

      it 'does not return items without the status of inactive' do
        expect(described_class.inactive).to_not include(active_item)
        expect(described_class.inactive).to_not include(in_cart_item)
      end
    end

    describe 'not_purchased' do
      it 'returns active items items' do
        expect(described_class.not_purchased).to include(active_item)
      end

      it 'returns in_cart items items' do
        expect(described_class.not_purchased).to include(in_cart_item)
      end

      it 'does not return inactive items' do
        expect(described_class.not_purchased).to_not include(inactive_item)
      end
    end
  end

  describe 'self.by_recently_edited' do
    it 'returns the most recently editied item first' do
      create(:shopping_list_item)
      item2 = create(:shopping_list_item)
      create(:shopping_list_item)

      item2.status = 'inactive'
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

  describe '#active?' do
    it 'returns true if the status is "active"' do
      item = build(:shopping_list_item, status: 'active')
      expect(item.active?).to eq(true)
    end

    it 'returns false if the status is not "active"' do
      item = build(:shopping_list_item, status: 'anything')
      expect(item.active?).to eq(false)
    end
  end

  describe '#inactive?' do
    it 'returns true if the status is "inactive"' do
      item = build(:shopping_list_item, status: 'inactive')
      expect(item.inactive?).to eq(true)
    end

    it 'returns false if the status is not "inactive"' do
      item = build(:shopping_list_item, status: 'anything')
      expect(item.inactive?).to eq(false)
    end
  end

  describe '#in_cart?' do
    it 'returns true if the status is "in_cart"' do
      item = build(:shopping_list_item, status: 'in_cart')
      expect(item.in_cart?).to eq(true)
    end

    it 'returns false if the status is not "in_cart"' do
      item = build(:shopping_list_item, status: 'anything')
      expect(item.in_cart?).to eq(false)
    end
  end

  describe '#deactivate!' do
    it 'sets the status attribute to "inactive" and saves the item' do
      item = build(:shopping_list_item, status: 'active')
      expect{ item.deactivate! }.to change{ item.status }.from('active').to('inactive')
    end
  end

  describe '#activate!' do
    it 'sets the "status" attribute to "active" and saves the item' do
      item = build(:shopping_list_item, status: 'inactive')
      expect{ item.activate! }.to change{ item.status }.from('inactive').to('active')
    end
  end

  describe '#add_to_cart!' do
    it 'sets the "status" attribute to "in_cart" and saves the item' do
      item = build(:shopping_list_item, status: 'active')
      expect{ item.add_to_cart! }.to change{ item.status }.from('active').to('in_cart')
    end
  end
end
