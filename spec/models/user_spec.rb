# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "associations" do
    it { should have_many(:recipes) }
    it { should have_many(:meal_plans) }
    it { should have_many(:shopping_lists) }
    it { should have_many(:aisles) }
  end

  describe "a valid user" do
    context "when has valid params" do
      it "is valid" do
        expect(user).to be_valid
      end
    end
  end

  describe "normalization" do
    it "strips leading/trailing blankspace and downcases the email before validation" do
      user = build(:user, email: "   foo@EMAIL.com  ")
      expect(user.valid?).to be(true)
      expect(user.email).to eq("foo@email.com")
    end
  end

  describe "#favorite_list" do
    let(:user) { create(:user) }
    let!(:fave_list) { create(:shopping_list, user: user, favorite: true) }
    let!(:other_list) { create(:shopping_list, user: user, favorite: false) }

    it "returns a single shopping list" do
      expect(user.favorite_list.class).to eq(ShoppingList)
    end

    it "returns a shopping_list that is marked as favorite for this user" do
      expect(user.favorite_list).to eq(fave_list)
      expect(user.favorite_list).not_to eq(other_list)
    end
  end
end
