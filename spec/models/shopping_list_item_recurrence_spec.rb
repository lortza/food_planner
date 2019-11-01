# frozen_string_literal: true

RSpec.describe ShoppingListItemRecurrence, type: :model do
  describe 'self.check_schedule' do
    it 'does not change non-recurring items' do
      item = create(:shopping_list_item, purchased: true, quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(item.purchased).to eq(true)
      expect(item.quantity).to eq(1)
    end

    it 'adds recurring items to list on its scheduled day' do
      allow(ShoppingListItemRecurrence).to receive(:today_is_weekly_item_day?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'weekly')

      allow(ShoppingListItemRecurrence).to receive(:today_is_biweekly_item_day?).and_return(true)
      biweekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'biweekly')

      allow(ShoppingListItemRecurrence).to receive(:today_is_monthly_item_day?).and_return(true)
      monthly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'monthly')

      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.purchased).to eq(false)
      expect(biweekly_item.reload.purchased).to eq(false)
      expect(monthly_item.reload.purchased).to eq(false)
    end

    it 'does not add recurring items to list on on non-scheduled days' do
      allow(ShoppingListItemRecurrence).to receive(:today_is_weekly_item_day?).and_return(false)
      weekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'weekly')

      allow(ShoppingListItemRecurrence).to receive(:today_is_biweekly_item_day?).and_return(false)
      biweekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'biweekly')

      allow(ShoppingListItemRecurrence).to receive(:today_is_monthly_item_day?).and_return(false)
      monthly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'monthly')

      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.purchased).to eq(true)
      expect(biweekly_item.reload.purchased).to eq(true)
      expect(monthly_item.reload.purchased).to eq(true)
    end

    it 'moves the item to "purchased" if the item is unpurchased' do
      allow(ShoppingListItemRecurrence).to receive(:today_is_weekly_item_day?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'weekly')
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.purchased).to eq(false)
    end

    it 'inserts the recurrence qty as the qty if the item had been purchased' do
      allow(ShoppingListItemRecurrence).to receive(:today_is_weekly_item_day?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, recurrence_frequency: 'weekly', quantity: 2, recurrence_quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.quantity).to eq(1)
    end

    it 'adds the recurrence qty to the existing qty if is is not purchased' do
      allow(ShoppingListItemRecurrence).to receive(:today_is_weekly_item_day?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: false, recurrence_frequency: 'weekly', quantity: 2, recurrence_quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.quantity).to eq(3)
    end
  end
end
