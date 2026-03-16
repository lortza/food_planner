# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "associations" do
    it { should have_many(:recipes) }
    it { should have_many(:meal_plans) }
    it { should have_many(:shopping_lists) }
    it { should have_many(:aisles) }
    it { should have_many(:tags) }
    it { should have_many(:notes) }
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
