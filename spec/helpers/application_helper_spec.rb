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

  describe "display_link_to_plan" do
    let(:current_user) { create(:user) }

    describe "when the current_user has an upcoming meal_plan" do
      it "returns a link to that meal_plan" do
        meal_plan = create(:meal_plan, user: current_user, prepared_on: (Time.zone.today + 5))
        expect(display_link_to_plan).to include("meal_plans/#{meal_plan.id}")
      end
    end

    describe "when the current_user does not have an upcoming meal_plan" do
      it "returns nil" do
        expect(display_link_to_plan).to be(nil)
      end
    end
  end

  describe "display_list_and_count" do
    let(:current_user) { create(:user) }

    describe "when a current_user has no shopping lists" do
      it "returns an empty string" do
        expect(display_list_and_count).to eq("")
      end
    end

    describe "when a current_user has a default shopping list" do
      let!(:list) {
        create(:shopping_list, user: current_user, name: "Foo", main: true)
      }

      it "returns a link to the list" do
        link = "<a class=\"nav-link\" href=\"/shopping_lists/#{list.id}\">"
        expect(display_list_and_count).to include(link)
      end

      it "includes the list name" do
        expect(display_list_and_count).to include("Foo: 0")
      end

      it "includes the item count" do
        create(:shopping_list_item, list: list)
        create(:shopping_list_item, list: list)
        expect(display_list_and_count).to include("Foo: 2")
      end
    end
  end
end
