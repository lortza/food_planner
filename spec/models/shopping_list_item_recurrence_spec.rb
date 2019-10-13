# frozen_string_literal: true

RSpec.describe ShoppingListItemRecurrence, type: :model do
  let(:shopping_list) { build(:shopping_list) }



  describe 'self.add_items_to_list' do
    # let(:user) { create(:user) }
    # let(:shopping_list) { create(:shopping_list, user: user) }
    xit 'moves the item to "unpurchased" if the item is purchased' do
    end

    xit 'inserts the recurrence qty as the qty if the item is purchased' do
    end

    xit 'adds the recurrence qty to the existing qty if is is not purchased' do
    end

  end


end
