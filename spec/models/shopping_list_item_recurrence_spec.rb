# frozen_string_literal: true

RSpec.describe ShoppingListItemRecurrence, type: :model do
  describe 'self.check_schedule' do
    it 'does not change non-recurring items' do
      item = create(:shopping_list_item, purchased: true, status: 'inactive', quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(item.active?).to eq(false)
      expect(item.quantity).to eq(1)
    end

    it 'adds recurring items to list on its scheduled day' do
      allow(ShoppingListItemRecurrence).to receive(:add_weekly_item?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'weekly')

      allow(ShoppingListItemRecurrence).to receive(:add_biweekly_item?).and_return(true)
      biweekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'biweekly')

      allow(ShoppingListItemRecurrence).to receive(:add_monthly_item?).and_return(true)
      monthly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'monthly')

      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.active?).to eq(true)
      expect(biweekly_item.reload.active?).to eq(true)
      expect(monthly_item.reload.active?).to eq(true)
    end

    it 'does not add recurring items to list on on non-scheduled days' do
      allow(ShoppingListItemRecurrence).to receive(:add_weekly_item?).and_return(false)
      weekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'weekly')

      allow(ShoppingListItemRecurrence).to receive(:add_biweekly_item?).and_return(false)
      biweekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'biweekly')

      allow(ShoppingListItemRecurrence).to receive(:add_monthly_item?).and_return(false)
      monthly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'monthly')

      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.active?).to eq(false)
      expect(biweekly_item.reload.active?).to eq(false)
      expect(monthly_item.reload.active?).to eq(false)
    end

    it 'moves the item to active if the item is inactive' do
      allow(ShoppingListItemRecurrence).to receive(:add_weekly_item?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'weekly')
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.purchased).to eq(false)
      expect(weekly_item.reload.active?).to eq(true)
    end

    it 'inserts the recurrence qty as the qty if the item is inactive' do
      allow(ShoppingListItemRecurrence).to receive(:add_weekly_item?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: true, status: 'inactive', recurrence_frequency: 'weekly', quantity: 2, recurrence_quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.quantity).to eq(1)
    end

    it 'adds the recurrence qty to the existing qty if is active' do
      allow(ShoppingListItemRecurrence).to receive(:add_weekly_item?).and_return(true)
      weekly_item = create(:shopping_list_item, purchased: false, status: 'active', recurrence_frequency: 'weekly', quantity: 2, recurrence_quantity: 1)
      ShoppingListItemRecurrence.check_schedule

      expect(weekly_item.reload.quantity).to eq(3)
    end
  end
end
