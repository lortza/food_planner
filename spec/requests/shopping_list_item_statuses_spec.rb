# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ShoppingListItemStatusesController", type: :request do
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }

  describe "unauthenticated access" do
    let(:item) { create(:shopping_list_item) }

    it "denies access to #activate" do
      post activate_item_path(item)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "denies access to #deactivate" do
      post deactivate_item_path(item)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "authenticated access" do
    let(:user) { create(:user) }
    let(:shopping_list) { create(:shopping_list, user: user) }

    before { sign_in(user) }

    describe "POST #activate" do
      context "when item is inactive" do
        let(:item) { create(:shopping_list_item, shopping_list: shopping_list, status: "inactive") }

        it "sets the item status to active" do
          post activate_item_path(item), headers: turbo_stream_headers

          expect(item.reload.status).to eq("active")
        end

        it "responds with turbo_stream" do
          post activate_item_path(item), headers: turbo_stream_headers

          expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        end
      end

      context "when item is in_cart" do
        let(:item) { create(:shopping_list_item, shopping_list: shopping_list, status: "in_cart") }

        it "keeps the item status as in_cart" do
          post activate_item_path(item), headers: turbo_stream_headers

          expect(item.reload.status).to eq("in_cart")
        end
      end
    end

    describe "POST #deactivate" do
      let(:item) { create(:shopping_list_item, shopping_list: shopping_list, status: "active") }

      it "sets the item status to inactive" do
        post deactivate_item_path(item), headers: turbo_stream_headers

        expect(item.reload.status).to eq("inactive")
      end

      it "responds with turbo_stream" do
        post deactivate_item_path(item), headers: turbo_stream_headers

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end
    end
  end
end
