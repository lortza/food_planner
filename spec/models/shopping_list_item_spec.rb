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
end
