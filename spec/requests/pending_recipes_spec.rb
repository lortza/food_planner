# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PendingRecipes", type: :request do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user_id: user.id, status: :pending) }

  describe "Public access to recipes" do
    it "denies access to recipes#new" do
      get new_recipe_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to recipes#create" do
      recipe_attributes = build(:recipe, user_id: user.id).attributes

      expect {
        post recipes_path(recipe_attributes)
      }.to_not change(Recipe, :count)

      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own recipes" do
    before :each do
      sign_in user
    end

    it "renders recipes#new" do
      get new_recipe_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders recipes#create" do
      recipe_attributes = build(:recipe, user: user).attributes

      expect {
        post recipes_path(recipe: recipe_attributes)
      }.to change(Recipe, :count)
    end
  end

  describe "Authenticated access to another user's recipes" do
    let(:author) { create(:user) }
    let(:others_recipe) { create(:recipe, user: author) }

    before :each do
      author
      others_recipe
      sign_in user
    end
  end
end
