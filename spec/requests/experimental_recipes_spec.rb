# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ExperimentalRecipes', type: :request do
  describe 'Public access to experimental_recipes' do
    let(:user) { create(:user) }
    let(:experimental_recipe) { create(:experimental_recipe, user_id: user.id) }

    before do
      user
      experimental_recipe
    end

    it 'denies access to experimental_recipes#index' do
      get experimental_recipes_path
      expect(response).to have_http_status(302)
    end

    it 'denies access to experimental_recipes#new' do
      get new_experimental_recipe_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to experimental_recipes#edit' do
      get edit_experimental_recipe_path(experimental_recipe.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to experimental_recipes#create' do
      experimental_recipe_attributes = build(:experimental_recipe, user_id: user.id).attributes

      expect {
        post experimental_recipes_path(experimental_recipe_attributes)
      }.to_not change(ExperimentalRecipe, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to experimental_recipes#update' do
      patch experimental_recipe_path(experimental_recipe, experimental_recipe: experimental_recipe.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to experimental_recipes#destroy' do
      delete experimental_recipe_path(experimental_recipe)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to own experimental_recipes' do
    let(:user) { create(:user) }
    let(:experimental_recipe) { create(:experimental_recipe, user_id: user.id) }

    before do
      user
      experimental_recipe
      sign_in(user)
    end

    it 'renders experimental_recipes#new' do
      get new_experimental_recipe_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders experimental_recipes#edit' do
      get edit_experimental_recipe_path(experimental_recipe.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(experimental_recipe.title)
    end

    it 'renders experimental_recipes#create' do
      experimental_recipe_attributes = build(:experimental_recipe, user: user).attributes

      expect {
        post experimental_recipes_path(experimental_recipe: experimental_recipe_attributes)
      }.to change(ExperimentalRecipe, :count)
    end

    it 'renders experimental_recipes#update' do
      new_title = 'completely different title'
      patch experimental_recipe_path(experimental_recipe, experimental_recipe: { title: new_title })

      expect(response).to redirect_to experimental_recipes_url
    end

    it 'renders experimental_recipes#destroy' do
      delete experimental_recipe_path(experimental_recipe)

      expect(response).to redirect_to experimental_recipes_url
      expect(response.body).to_not include(experimental_recipe.title)
    end
  end

  describe "Authenticated access to another user's experimental_recipes" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:others_experimental_recipe) { create(:experimental_recipe, user_id: other_user.id) }

    before do
      user
      other_user
      others_experimental_recipe
      sign_in(user)
    end

    it 'denies access to experimental_recipes#edit' do
      get edit_experimental_recipe_path(others_experimental_recipe.id)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it 'denies access to experimental_recipes#update' do
      new_title = 'completely different title'
      patch experimental_recipe_path(others_experimental_recipe, experimental_recipe: { title: new_title })

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it 'denies access to experimental_recipes#destroy' do
      delete experimental_recipe_path(others_experimental_recipe)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end
  end
end
