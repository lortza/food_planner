# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MealPlanAssistants", type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user, title: "Black Bean Chili", servings: 6) }
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }
  let(:prep_day) { MealPlanAssistant.prep_day_for(user) }
  let(:reply) do
    MealPlanAssistant::Reply.new(
      message: "Here are some cozy ideas.",
      suggestions: [MealPlanAssistant::Suggestion.new(recipe: recipe, reason: "Not made since August.")],
      history: [{role: "user", content: "cozy"}, {role: "assistant", content: "{}"}]
    )
  end

  before { allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new) }

  describe "unauthenticated access" do
    it "redirects show to sign in" do
      get meal_plan_assistant_path

      expect(response).to redirect_to new_user_session_path
    end

    it "does not call Claude" do
      allow(MealPlanAssistant).to receive(:reply)

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      expect(response).to have_http_status(:unauthorized).or redirect_to(new_user_session_path)
      expect(MealPlanAssistant).not_to have_received(:reply)
    end
  end

  describe "authenticated access" do
    before { sign_in user }

    it "renders the chat page with the prep day" do
      get meal_plan_assistant_path

      expect(response).to be_successful
      expect(response.body).to include("Plan with Claude")
      expect(response.body).to include("Surprise me")
      expect(response.body).to include(I18n.l(prep_day, format: :month_as_text))
    end

    it "shows recipes already on the upcoming meal plan in the tray" do
      meal_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 3)
      meal_plan.recipes << recipe

      get meal_plan_assistant_path

      expect(response.body).to include('data-meal-plan-assistant-target="trayItem"')
      expect(response.body).to include("Black Bean Chili")
      expect(response.body).to include(meal_plan_path(meal_plan))
    end

    it "streams back the reply, saves the conversation, and shows it again on reload" do
      allow(MealPlanAssistant).to receive(:reply).and_return(reply)

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(response.body).to include("Here are some cozy ideas.")
      expect(response.body).to include("Not made since August.")
      expect(response.body).to include(meal_plan_assistant_recipes_path)

      get meal_plan_assistant_path

      expect(response.body).to include("Here are some cozy ideas.")
      expect(response.body).to include("Start over")
    end

    it "sends the saved history and the upcoming meal plan's recipes to the assistant" do
      meal_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 3)
      meal_plan.recipes << recipe
      allow(MealPlanAssistant).to receive(:reply).and_return(reply)

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers
      post meal_plan_assistant_path, params: {message: "lighter"}, headers: turbo_stream_headers

      expect(MealPlanAssistant).to have_received(:reply).with(
        user: user,
        message: "lighter",
        history: reply.history.map(&:stringify_keys),
        tray_recipe_ids: [recipe.id],
        prep_day: meal_plan.prepared_on
      )
    end

    it "uses a starter button's value as the message" do
      allow(MealPlanAssistant).to receive(:reply).and_raise(MealPlanAssistant::Error, "nope")

      post meal_plan_assistant_path, params: {starter: "Surprise me", message: ""}, headers: turbo_stream_headers

      expect(MealPlanAssistant).to have_received(:reply).with(hash_including(message: "Surprise me"))
    end

    it "streams back a friendly error and doesn't save the failed turn" do
      allow(MealPlanAssistant).to receive(:reply).and_raise(MealPlanAssistant::Error, "Sorry, please try again.")

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      expect(response).to be_successful
      expect(response.body).to include("Sorry, please try again.")
      expect(MealPlanAssistant::Conversation.new(user: user, prep_day: prep_day).turns).to be_empty
    end

    it "starts over by clearing the conversation but not the meal plan" do
      meal_plan = create(:meal_plan, user: user, prepared_on: Time.zone.today + 3)
      meal_plan.recipes << recipe
      allow(MealPlanAssistant).to receive(:reply).and_return(reply)
      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      delete meal_plan_assistant_path

      expect(response).to redirect_to(meal_plan_assistant_path)
      expect(MealPlanAssistant::Conversation.new(user: user, prep_day: meal_plan.prepared_on).turns).to be_empty
      expect(meal_plan.reload.recipes).to eq([recipe])
    end
  end
end
