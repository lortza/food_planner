# frozen_string_literal: true

RSpec.describe ShoppingList, type: :model do
  let(:shopping_list) { build(:shopping_list) }

  describe 'a valid shopping_list' do
    context 'when has valid params' do
      it 'is valid' do
        expect(shopping_list).to be_valid
      end

      it { should validate_presence_of(:name) }
    end
  end
end
