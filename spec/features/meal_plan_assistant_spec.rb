# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Planning a week with the meal plan assistant", type: :feature, js: true do
  let(:user) { create(:user) }
  let(:chili) { create(:recipe, user: user, title: "Black Bean Chili", servings: 6) }
  let(:noodles) { create(:recipe, user: user, title: "Sesame Noodles", servings: 4) }
  let(:reply) do
    MealPlanAssistant::Reply.new(
      message: "Here are some cozy ideas.",
      suggestions: [
        MealPlanAssistant::Suggestion.new(recipe: chili, reason: "Hearty and warming."),
        MealPlanAssistant::Suggestion.new(recipe: noodles, reason: "Quick weeknight option.")
      ],
      history: [{role: "user", content: "Something cozy"}, {role: "assistant", content: "{}"}]
    )
  end

  before do
    allow(MealPlanAssistant).to receive(:reply).and_return(reply)
    sign_in user
  end

  scenario "picking suggested recipes and starting a meal plan with them" do
    visit meal_plan_assistant_path
    click_button "Something cozy"

    expect(page).to have_content("Here are some cozy ideas.")
    expect(page).to have_content("Hearty and warming.")

    within(".card", text: "Black Bean Chili") { click_button "+ Add" }

    within(".meal-plan-assistant-tray") do
      expect(page).to have_content("Black Bean Chili (serves 6)")
      expect(page).to have_content("1 recipe · 6 servings")
    end
    expect(page).to have_button("Added", disabled: true)

    fill_in "message", with: "Something lighter"
    click_button "Ask"

    expect(page).to have_content("Something lighter")
    expect(MealPlanAssistant).to have_received(:reply).with(
      hash_including(message: "Something lighter", tray_recipe_ids: [chili.id], history: reply.history.as_json)
    )

    within(".meal-plan-assistant-tray") { click_link "Create meal plan" }

    expect(page).to have_current_path(/#{new_meal_plan_path}/)
    expect(page).to have_checked_field("meal_plan_recipe_ids_#{chili.id}")
    expect(page).to have_unchecked_field("meal_plan_recipe_ids_#{noodles.id}")
  end
end
