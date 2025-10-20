# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tags", type: :request do
  describe "Public access to tags" do
    let(:user) { create(:user) }
    let(:user_tag) { create(:tag, user: user) }

    before :each do
      user_tag
    end

    it "denies access to tags#show" do
      get tag_path(user_tag.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own tags" do
    let(:user) { create(:user) }
    let(:user_tag) { create(:tag, user: user) }

    before :each do
      sign_in user
      user_tag
    end

    it "allows access to tags#show" do
      get tag_path(user_tag.id)

      expect(response).to have_http_status(200)
    end
  end

  describe "Authenticated access to another user's tags" do
    let(:user) { create(:user) }
    let(:different_user) { create(:user) }
    let(:different_user_tag) { create(:tag, user: different_user) }

    before :each do
      sign_in user
      different_user_tag
    end

    it "denies access to tags#show" do
      get tag_path(different_user_tag.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_path
    end
  end
end
