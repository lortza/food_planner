# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user_id: user.id) }

  describe 'Public access to recipes' do
    describe "GET /recipes/id" do
      it 'permits access to recipes#show' do
        get recipe_path(recipe)
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /recipes" do
      it 'denies access to recipes#index' do
        get recipes_path
        expect(response).to have_http_status(302)
      end
    end

    it 'denies access to recipes#new' do
      get new_recipe_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to recipes#edit' do
      get edit_recipe_path(recipe.id)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to recipes#create' do
      recipe_attributes = build(:recipe, user_id: user.id).attributes

      expect {
        post recipes_path(recipe_attributes)
      }.to_not change(Recipe, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to recipes#update' do
      patch recipe_path(recipe, recipe: recipe.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it 'denies access to recipes#destroy' do
      delete recipe_path(recipe)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'Authenticated access to own recipes' do
    before :each do
      sign_in user
    end

    it 'renders recipes#show' do
      get recipe_path(recipe.id)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'renders recipes#new' do
      get new_recipe_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'renders recipes#edit' do
      get edit_recipe_path(recipe.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
      expect(response.body).to include(recipe.title)
    end

    it 'renders recipes#create' do
      recipe_attributes = build(:recipe, user: user).attributes

      expect {
        post recipes_path(recipe: recipe_attributes)
      }.to change(Recipe, :count)
    end

    it 'renders recipes#update' do
      new_title = 'completely different title'
      patch recipe_path(recipe, recipe: { title: new_title })

      expect(response).to redirect_to recipe_url(recipe)
    end

    it 'renders recipes#destroy' do
      delete recipe_path(recipe)

      expect(response).to redirect_to recipes_url
      expect(response.body).to_not include(recipe.title)
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

    it 'renders recipes#show' do
      get recipe_path(others_recipe.id)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it 'denies access to recipes#edit' do
      get edit_recipe_path(others_recipe.id)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it 'denies access to recipes#update' do
      new_title = 'completely different title'
      patch recipe_path(others_recipe, recipe: { title: new_title })

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it 'denies access to recipes#destroy' do
      delete recipe_path(others_recipe)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end
  end
end
