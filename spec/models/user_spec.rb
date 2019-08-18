# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'associations' do
    it { should have_many(:recipes) }
    it { should have_many(:meal_plans) }
    it { should have_many(:shopping_lists) }
    it { should have_many(:aisles) }
  end

  describe '#favorite_list' do
    xit 'returns a single shopping list' do
    end

    xit 'returns a shopping_list that is marked as favorite for this user' do
    end
  end
end
