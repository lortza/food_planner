# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Ingredients", type: :request do
  let(:user) { create(:user) }

  before { user }

  describe "GET /ingredients/new" do
    context "when unauthenticated" do
      it "redirects to sign in" do
        get new_ingredient_path, headers: {"Accept" => "text/vnd.turbo-stream.html"}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "returns a turbo stream response" do
        get new_ingredient_path, headers: {"Accept" => "text/vnd.turbo-stream.html"}
        expect(response).to be_successful
        expect(response.media_type).to eq "text/vnd.turbo-stream.html"
      end

      it "renders the new template" do
        get new_ingredient_path, headers: {"Accept" => "text/vnd.turbo-stream.html"}
        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end
  end
end
