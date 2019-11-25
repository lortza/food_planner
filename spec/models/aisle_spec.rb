# frozen_string_literal: true

RSpec.describe Aisle, type: :model do
  let(:aisle) { build(:aisle) }

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:shopping_list_items) }
  end

  describe 'a valid aisle' do
    context 'when has valid params' do
      it 'is valid' do
        expect(aisle).to be_valid
      end

      it { should validate_presence_of(:order_number) }
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    end
  end

  describe 'self.unassigned' do
    let(:user) { create(:user) }
    let(:shopping_list) { create(:shopping_list, user: user) }

    it 'returns the existing aisle called "Unassigned" that belongs to the current_user' do
      existing_aisle = create(:aisle, user: user, name: 'Unassigned')
      retured_aisle = Aisle.unassigned(shopping_list)

      expect(retured_aisle).to eq(existing_aisle)
    end

    it 'creates a new aisle called "Unassigned" for the user if one does not exist' do
      retured_aisle = Aisle.unassigned(shopping_list)

      expect(retured_aisle.name).to eq('unassigned')
    end
  end
end
