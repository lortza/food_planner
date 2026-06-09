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

  describe "creating a pending recipe from an uploaded image" do
    let(:image) { fixture_file_upload(Rails.root.join("spec/fixtures/files/recipe.png"), "image/png") }

    before { sign_in user }

    it "passes the uploaded image to the extractor and persists a pending recipe" do
      received_kwargs = nil
      allow(RecipeDataExtractor).to receive(:extract) do |**kwargs|
        received_kwargs = kwargs
        {"title" => "Recipe From Image"}
      end

      expect {
        post pending_recipes_path, params: {recipe: {status: "pending", source_url: "", title: ""}, image_upload: image}
      }.to change(Recipe, :count).by(1)

      expect(received_kwargs[:image]).to be_present
      expect(response).to have_http_status(:redirect)
      expect(Recipe.last.title).to eq("Recipe From Image")
    end

    it "does not let the transient upload populate the persisted image_url" do
      allow(RecipeDataExtractor).to receive(:extract).and_return("title" => "No Image URL Recipe")

      post pending_recipes_path, params: {recipe: {status: "pending", source_url: "", title: ""}, image_upload: image}

      expect(Recipe.last.image_url).to eq("")
    end
  end
end
