# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tags", type: :request do
  describe "Public access to tags" do
    let(:user) { create(:user) }
    let(:user_tag) { create(:tag, user: user) }

    before :each do
      user_tag
    end

    it "denies access to tags#index" do
      get tags_path(user_tag.id)

      expect(response).to have_http_status(401)
    end

    it "denies access to tags#new" do
      get new_tag_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to tags#create" do
      tag_attributes = build(:tag, user: user).attributes

      expect {
        post tags_path(tag_attributes)
      }.to_not change(Tag, :count)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to tags#show" do
      get tag_path(user_tag.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to tags#edit" do
      get tag_path(user_tag.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to tags#update" do
      patch tag_path(user_tag, tag: user_tag.attributes)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to tags#destroy" do
      delete tag_path(user_tag)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own tags" do
    let(:user) { create(:user) }
    let(:user_tag) { create(:tag, user: user) }

    before :each do
      user_tag
      sign_in(user)
    end

    it "renders tags#new" do
      get new_tag_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders tags#edit" do
      get edit_tag_path(user_tag.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it "renders tags#create" do
      starting_count = Tag.count
      tag_attributes = build(:tag, user: user).attributes
      post tags_path(tag: tag_attributes)

      expect(Tag.count).to eq(starting_count + 1)
    end

    it "renders tags#update" do
      new_name = "different name"
      patch tag_path(user_tag, tag: {name: new_name})

      expect(response).to redirect_to tags_url
    end

    it "renders tags#destroy" do
      delete tag_path(user_tag)

      expect(response).to redirect_to(tags_url)
    end
  end

  describe "Authenticated access to another user's tags" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_tag) { create(:tag, user: user2) }

    before :each do
      user2_tag
      sign_in(user1)
    end

    it "denies access to tags#edit" do
      get edit_tag_path(user2_tag.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end

    it "denies access to tags#update" do
      new_name = "completely different name"
      patch tag_path(user2_tag, tag: {name: new_name})

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it "denies access to tags#destroy" do
      delete tag_path(user2_tag)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end
  end
end
