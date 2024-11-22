# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Inventories", type: :request do
  describe "Public access to inventories" do
    let(:user) { create(:user) }
    let(:user_inventory) { create(:inventory, user: user) }

    before :each do
      user_inventory
    end

    it "denies access to inventories#edit" do
      get edit_inventory_path(user_inventory.id)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to inventories#update" do
      patch inventory_path(user_inventory, inventory: user_inventory.attributes)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own inventories" do
    let(:user) { create(:user) }
    let(:user_inventory) { create(:inventory, user: user) }

    before :each do
      user_inventory
      sign_in(user)
    end

    it "renders inventories#edit" do
      get edit_inventory_path(user_inventory.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it "renders inventories#update" do
      new_items = "different items"
      patch inventory_path(user_inventory, inventory: {items: new_items})

      expect(response).to redirect_to inventory_recipe_suggestions_path(user_inventory.id)
    end
  end

  describe "Authenticated access to another user's inventories" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_inventory) { create(:inventory, user: user2) }

    before :each do
      user2_inventory
      sign_in(user1)
    end

    it "denies access to inventories#edit" do
      get edit_inventory_path(user2_inventory.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end

    it "denies access to inventories#update" do
      new_items = "completely different items"
      patch inventory_path(user2_inventory, inventory: {items: new_items})

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end
  end
end
