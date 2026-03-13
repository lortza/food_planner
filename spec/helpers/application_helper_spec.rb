# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "session_links" do
    describe "when a user is logged in" do
      let(:current_user) { create(:user) }

      it "it shows a link to sign out" do
        expect(session_links).to include("Sign Out")
      end
    end

    describe "there is no current user session" do
      let(:current_user) { nil }

      it "shows a link to sign in" do
        expect(session_links).to include("Sign In")
      end
    end
  end

  describe "display_time" do
    it "calls the TimeHelper method" do
      expect(TimeHelper).to receive(:display_time)
      display_time(120)
    end
  end

  describe "update_nav_bar_shopping_list_count?" do
    let(:shopping_list) { create(:shopping_list) }

    context "when there is no nav bar shopping list" do
      before { helper.singleton_class.define_method(:nav_bar_shopping_list) { nil } }

      it "returns false" do
        expect(helper.update_nav_bar_shopping_list_count?(shopping_list)).to be_falsy
      end
    end

    context "when the shopping list matches the nav bar shopping list" do
      before do
        list = shopping_list
        helper.singleton_class.define_method(:nav_bar_shopping_list) { list }
      end

      it "returns true" do
        expect(helper.update_nav_bar_shopping_list_count?(shopping_list)).to be_truthy
      end
    end

    context "when the shopping list does not match the nav bar shopping list" do
      let(:other_list) { create(:shopping_list) }

      before do
        list = other_list
        helper.singleton_class.define_method(:nav_bar_shopping_list) { list }
      end

      it "returns false" do
        expect(helper.update_nav_bar_shopping_list_count?(shopping_list)).to be_falsy
      end
    end
  end
end
