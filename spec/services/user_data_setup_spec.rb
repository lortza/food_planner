# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDataSetup, type: :service do
  let(:user) { create(:user) }

  describe 'self.setup' do
    it 'populates default shopping_lists' do
      shopping_list_count_before = user.shopping_lists.count
      expect(shopping_list_count_before).to eq(0)

      UserDataSetup.setup(user)
      user.reload
      shopping_list_count_after = user.shopping_lists.count

      expect(shopping_list_count_before).to be < shopping_list_count_after
      expect(user.shopping_lists.count).to be > 0
    end

    it 'populates default aisles' do
      aisle_count_before = user.aisles.count
      expect(aisle_count_before).to eq(0)

      UserDataSetup.setup(user)
      user.reload
      aisle_count_after = user.aisles.count

      expect(aisle_count_before).to be < aisle_count_after
      expect(user.aisles.count).to be > 0
    end
  end
end
