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

      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    end
  end
end
