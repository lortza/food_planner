# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  describe 'Public access to shopping_lists' do
    let(:user) { create(:user) }
    let(:user_shopping_list) { create(:shopping_list, user: user) }

    before :each do
      user_shopping_list
    end

    it 'denies access to shopping_lists#show' do
      get shopping_list_path(user_shopping_list)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#index' do
      get shopping_lists_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#new' do
      get new_shopping_list_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#edit' do
      get edit_shopping_list_path(user_shopping_list.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#create' do
      shopping_list_attributes = build(:shopping_list, user: user).attributes

      expect {
        post shopping_lists_path(shopping_list_attributes)
      }.to_not change(ShoppingList, :count)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#update' do
      patch shopping_list_path(user_shopping_list, shopping_list: user_shopping_list.attributes)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to shopping_lists#destroy' do
      delete shopping_list_path(user_shopping_list)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to own shopping_lists' do
    let(:user) { create(:user) }
    let(:user_shopping_list_default) { create(:shopping_list, main: true, user: user) }
    let(:user_shopping_list) { create(:shopping_list, user: user) }

    before :each do
      user_shopping_list_default
      user_shopping_list
      sign_in(user)
    end

    it 'renders shopping_lists#show' do
      get shopping_list_path(user_shopping_list)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'renders shopping_lists#edit' do
      get edit_shopping_list_path(user_shopping_list.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'renders shopping_lists#create' do
      starting_count = ShoppingList.count
      shopping_list_attributes = build(:shopping_list, user: user).attributes
      post shopping_lists_path(shopping_list: shopping_list_attributes)

      expect(ShoppingList.count).to eq(starting_count + 1)
    end

    it 'renders shopping_lists#update' do
      new_name = 'different name'
      patch shopping_list_path(user_shopping_list, shopping_list: { name: new_name })

      expect(response).to redirect_to shopping_list_url(user_shopping_list)
    end

    it 'renders shopping_lists#destroy' do
      delete shopping_list_path(user_shopping_list)

      expect(response).to redirect_to(shopping_lists_url)
      expect(response.body).to include(shopping_lists_url)
    end
  end

  describe "Authenticated access to another user's shopping_lists" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_shopping_list) { create(:shopping_list, user: user2) }

    before :each do
      user2_shopping_list
      sign_in(user1)
    end

    it 'denies access to shopping_lists#show' do
      get shopping_list_path(user2_shopping_list.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end

    it 'denies access to shopping_lists#edit' do
      get edit_shopping_list_path(user2_shopping_list.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end

    it 'denies access to shopping_lists#update' do
      new_name = 'completely different name'
      patch shopping_list_path(user2_shopping_list, shopping_list: { name: new_name })

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it 'denies access to shopping_lists#destroy' do
      delete shopping_list_path(user2_shopping_list)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end
  end
end
