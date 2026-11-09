# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MealPlanAssistants", type: :request do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user, title: "Black Bean Chili", servings: 6) }
  let(:turbo_stream_headers) { {"Accept" => "text/vnd.turbo-stream.html"} }

  describe "unauthenticated access" do
    it "redirects show to sign in" do
      get meal_plan_assistant_path

      expect(response).to redirect_to new_user_session_path
    end

    it "redirects create to sign in without calling Claude" do
      allow(MealPlanAssistant).to receive(:reply)

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      expect(response).to have_http_status(:unauthorized).or redirect_to(new_user_session_path)
      expect(MealPlanAssistant).not_to have_received(:reply)
    end
  end

  describe "authenticated access" do
    before { sign_in user }

    it "renders the chat page" do
      get meal_plan_assistant_path

      expect(response).to be_successful
      expect(response.body).to include("Plan with Claude")
      expect(response.body).to include("Surprise me")
    end

    it "streams back the message, suggestion cards, and updated history" do
      reply = MealPlanAssistant::Reply.new(
        message: "Here are some cozy ideas.",
        suggestions: [MealPlanAssistant::Suggestion.new(recipe: recipe, reason: "Not made since August.")],
        history: [{role: "user", content: "cozy"}, {role: "assistant", content: "{}"}]
      )
      allow(MealPlanAssistant).to receive(:reply).and_return(reply)

      post meal_plan_assistant_path,
        params: {message: "cozy", history: "[]", tray_recipe_ids: [recipe.id.to_s]},
        headers: turbo_stream_headers

      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(response.body).to include("Here are some cozy ideas.")
      expect(response.body).to include("Black Bean Chili")
      expect(response.body).to include("Not made since August.")
      expect(response.body).to include('data-meal-plan-assistant-id-param="' + recipe.id.to_s + '"')
      expect(response.body).to include("assistant_history")
      expect(MealPlanAssistant).to have_received(:reply).with(
        user: user, message: "cozy", history: [], tray_recipe_ids: [recipe.id]
      )
    end

    it "uses a starter button's value as the message" do
      allow(MealPlanAssistant).to receive(:reply).and_raise(MealPlanAssistant::Error, "nope")

      post meal_plan_assistant_path, params: {starter: "Surprise me", message: ""}, headers: turbo_stream_headers

      expect(MealPlanAssistant).to have_received(:reply).with(hash_including(message: "Surprise me"))
    end

    it "treats unparseable history as a fresh conversation" do
      allow(MealPlanAssistant).to receive(:reply).and_raise(MealPlanAssistant::Error, "nope")

      post meal_plan_assistant_path, params: {message: "cozy", history: "{not json"}, headers: turbo_stream_headers

      expect(MealPlanAssistant).to have_received(:reply).with(hash_including(history: []))
    end

    it "streams back a friendly error when the assistant fails" do
      allow(MealPlanAssistant).to receive(:reply).and_raise(MealPlanAssistant::Error, "Sorry, please try again.")

      post meal_plan_assistant_path, params: {message: "cozy"}, headers: turbo_stream_headers

      expect(response).to be_successful
      expect(response.body).to include("Sorry, please try again.")
      expect(response.body).not_to include("assistant_history")
    end
  end
end
