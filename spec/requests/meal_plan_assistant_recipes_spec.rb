# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MealPlanAssistantRecipes", type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user, title: "Black Bean Chili", servings: 6) }
  let(:other_recipe) { create(:recipe, user: user, title: "Sesame Noodles", servings: 4) }
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }

  it "requires sign in" do
    post meal_plan_assistant_recipes_path, params: {recipe_id: recipe.id}, headers: turbo_stream_headers

    expect(response).to have_http_status(:unauthorized).or redirect_to(new_user_session_path)
    expect(MealPlan.count).to eq(0)
  end

  describe "signed in" do
    before { sign_in user }

    context "with no upcoming meal plan" do
      it "creates the meal plan for the prep day with the recipe and streams the tray" do
        prep_day = MealPlanAssistant.prep_day_for(user)

        expect {
          post meal_plan_assistant_recipes_path, params: {recipe_id: recipe.id}, headers: turbo_stream_headers
        }.to change(user.meal_plans, :count).by(1)

        meal_plan = user.meal_plans.last
        expect(meal_plan.prepared_on).to eq(prep_day)
        expect(meal_plan.people_served).to eq(2)
        expect(meal_plan.recipes).to eq([recipe])
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(response.body).to include('target="assistant_tray"')
        expect(response.body).to include("Black Bean Chili")
      end
    end

    context "with an upcoming meal plan" do
      let(:meal_plan) { create(:meal_plan, user: user, prepared_on: Time.zone.today + 3) }

      before { meal_plan.recipes << recipe }

      it "adds to the existing meal plan" do
        expect {
          post meal_plan_assistant_recipes_path, params: {recipe_id: other_recipe.id}, headers: turbo_stream_headers
        }.not_to change(MealPlan, :count)

        expect(meal_plan.reload.recipes).to contain_exactly(recipe, other_recipe)
      end

      it "doesn't add the same recipe twice" do
        post meal_plan_assistant_recipes_path, params: {recipe_id: recipe.id}, headers: turbo_stream_headers

        expect(meal_plan.reload.recipes).to eq([recipe])
      end

      it "updates the recipe's last prepared date" do
        post meal_plan_assistant_recipes_path, params: {recipe_id: other_recipe.id}, headers: turbo_stream_headers

        expect(other_recipe.reload.last_prepared_on).to eq(meal_plan.prepared_on)
      end

      it "removes a recipe from the meal plan" do
        delete meal_plan_assistant_recipe_path(recipe), headers: turbo_stream_headers

        expect(meal_plan.reload.recipes).to be_empty
        expect(response.body).to include('target="assistant_tray"')
      end
    end

    it "won't add another user's recipe" do
      someone_elses = create(:recipe)

      post meal_plan_assistant_recipes_path, params: {recipe_id: someone_elses.id}, headers: turbo_stream_headers

      expect(response).to have_http_status(:not_found)
      expect(MealPlan.count).to eq(0)
    end

    it "does nothing when removing a recipe that isn't on the plan" do
      delete meal_plan_assistant_recipe_path(recipe), headers: turbo_stream_headers

      expect(response).to be_successful
    end
  end
end
