# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Aisles", type: :request do
  describe "Public access to aisles" do
    let(:user) { create(:user) }
    let(:user_aisle) { create(:aisle, user: user) }

    before :each do
      user_aisle
    end

    it "denies access to aisles#index" do
      get aisles_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to aisles#new" do
      get new_aisle_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to aisles#edit" do
      get edit_aisle_path(user_aisle.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to aisles#create" do
      aisle_attributes = build(:aisle, user: user).attributes

      expect {
        post aisles_path(aisle_attributes)
      }.to_not change(Aisle, :count)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to aisles#update" do
      patch aisle_path(user_aisle, aisle: user_aisle.attributes)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to aisles#destroy" do
      delete aisle_path(user_aisle)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own aisles" do
    let(:user) { create(:user) }
    let(:user_aisle) { create(:aisle, user: user) }

    before :each do
      user_aisle
      sign_in(user)
    end

    it "renders aisles#new" do
      get new_aisle_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders aisles#edit" do
      get edit_aisle_path(user_aisle.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it "renders aisles#create" do
      starting_count = Aisle.count
      aisle_attributes = build(:aisle, user: user).attributes
      post aisles_path(aisle: aisle_attributes)

      expect(Aisle.count).to eq(starting_count + 1)
    end

    it "renders aisles#update" do
      new_name = "different name"
      patch aisle_path(user_aisle, aisle: {name: new_name})

      expect(response).to redirect_to aisles_url
    end

    it "renders aisles#destroy" do
      delete aisle_path(user_aisle)

      expect(response).to redirect_to(aisles_url)
    end
  end

  describe "Authenticated access to another user's aisles" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_aisle) { create(:aisle, user: user2) }

    before :each do
      user2_aisle
      sign_in(user1)
    end

    it "denies access to aisles#edit" do
      get edit_aisle_path(user2_aisle.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end

    it "denies access to aisles#update" do
      new_name = "completely different name"
      patch aisle_path(user2_aisle, aisle: {name: new_name})

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it "denies access to aisles#destroy" do
      delete aisle_path(user2_aisle)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end
  end
end
