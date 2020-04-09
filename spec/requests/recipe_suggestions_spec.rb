# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecipeSuggestions', type: :request do
  describe 'Public access to recipe_suggestions' do
    let(:user) { create(:user) }
    let(:user_inventory) { create(:inventory, user: user) }

    before :each do
      user_inventory
    end

    it 'denies access to inventory_recipe_suggestions#index' do
      get inventory_recipe_suggestions_path(user_inventory.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to own recipe_suggestions' do
    let(:user) { create(:user) }
    let(:user_inventory) { create(:inventory, user: user) }

    before :each do
      user_inventory
      sign_in(user)
    end

    it 'renders recipe_suggestions#index' do
      get inventory_recipe_suggestions_path(user_inventory.id)

      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
  end

  describe "Authenticated access to another user's recipe_suggestions" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_inventory) { create(:inventory, user: user2) }

    before :each do
      user2_inventory
      sign_in(user1)
    end

    it 'denies access to recipe_suggestions#index' do
      get inventory_recipe_suggestions_path(user2_inventory.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end
  end
end
