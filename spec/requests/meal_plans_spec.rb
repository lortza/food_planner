# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MealPlans", type: :request do
  describe "Public access to meal_plans" do
    let(:user) { create(:user) }
    let(:user_recipe) { create(:recipe, user: user) }
    let(:user_meal_plan) { create(:meal_plan, user_id: user.id) }

    before :each do
      user_meal_plan.recipes.push(user_recipe)
    end

    it "denies access to meal_plans#show" do
      get meal_plan_path(user_meal_plan)

      expect(response).to have_http_status(302)
      expect(response).to have_http_status(302)
    end

    it "denies access to meal_plans#index" do
      get meal_plans_path
      expect(response).to have_http_status(302)
    end

    it "denies access to meal_plans#new" do
      get new_meal_plan_path
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to meal_plans#edit" do
      get edit_meal_plan_path(user_meal_plan.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to meal_plans#create" do
      meal_plan_attributes = build(:meal_plan, user: user).attributes

      expect {
        post meal_plans_path(meal_plan_attributes)
      }.to_not change(MealPlan, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to meal_plans#update" do
      patch meal_plan_path(user_meal_plan, meal_plan: user_meal_plan.attributes)
      expect(response).to redirect_to new_user_session_path
    end

    it "denies access to meal_plans#destroy" do
      delete meal_plan_path(user_meal_plan)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "Authenticated access to own meal_plans" do
    let(:user) { create(:user) }
    let(:user_recipe) { create(:recipe, user: user) }
    let(:user_meal_plan) { create(:meal_plan, user_id: user.id) }

    before :each do
      user_meal_plan.recipes.push(user_recipe)
      sign_in user
    end

    it "renders meal_plans#show" do
      get meal_plan_path(user_meal_plan)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "renders meal_plans#new" do
      get new_meal_plan_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it "renders meal_plans#edit" do
      get edit_meal_plan_path(user_meal_plan.id)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    describe "#create" do
      context "when the save is successful" do
        it "creates a new record" do
          starting_count = MealPlan.count
          meal_plan_attributes = build(:meal_plan, user: user).attributes
          post meal_plans_path(meal_plan: meal_plan_attributes)

          expect(MealPlan.count).to eq(starting_count + 1)
        end

        it "redirects to the new record" do
          meal_plan_attributes = build(:meal_plan, user: user).attributes
          post meal_plans_path(meal_plan: meal_plan_attributes)

          expect(response).to redirect_to meal_plan_url(user.meal_plans.reload.last)
        end
      end

      context "when the save is unsuccessful" do
        it "renders :new" do
          same_date = "2024-04-01"
          create(:meal_plan, prepared_on: same_date, user: user)
          meal_plan_attributes = build(:meal_plan, prepared_on: same_date, user: user).attributes
          post meal_plans_path(meal_plan: meal_plan_attributes)

          expect(response).to render_template(:new)
        end
      end
    end

    describe "#update" do
      context "when the update is successful" do
        it "redirects to the meal_plan" do
          new_prepared_on = Time.zone.now + 15
          patch meal_plan_path(user_meal_plan, meal_plan: {prepared_on: new_prepared_on})

          expect(response).to redirect_to meal_plan_url(user_meal_plan)
        end
      end

      context "when the update is unsuccessful" do
        it "redirects to the meal_plan" do
          same_date = "2024-04-01"
          create(:meal_plan, prepared_on: same_date, user: user)
          patch meal_plan_path(user_meal_plan, meal_plan: {prepared_on: same_date})

          expect(response).to render_template(:edit)
        end
      end
    end

    it "renders meal_plans#destroy" do
      delete meal_plan_path(user_meal_plan)

      expect(response).to redirect_to meal_plans_url
    end
  end

  describe "Authenticated access to another user's meal_plans" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user2_recipe) { create(:recipe, user: user2) }
    let(:user2_meal_plan) { create(:meal_plan, user: user2) }

    before :each do
      user2_meal_plan.recipes.push(user2_recipe)
      sign_in user1
    end

    it "denies access to meal_plans#show" do
      get meal_plan_path(user2_meal_plan.id)

      expect(response).to_not be_successful
      expect(response).to have_http_status(302)
    end

    it "denies access to meal_plans#edit" do
      get edit_meal_plan_path(user2_meal_plan.id)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it "denies access to meal_plans#update" do
      new_prepared_on = "completely different prepared_on"
      patch meal_plan_path(user2_meal_plan, meal_plan: {prepared_on: new_prepared_on})

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end

    it "denies access to meal_plans#destroy" do
      delete meal_plan_path(user2_meal_plan)

      expect(response).to_not be_successful
      expect(response).to redirect_to root_url
    end
  end
end
