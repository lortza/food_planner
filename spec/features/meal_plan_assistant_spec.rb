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
    allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new)
    allow(MealPlanAssistant).to receive(:reply).and_return(reply)
    sign_in user
  end

  scenario "adding suggestions to the meal plan, leaving, and coming back to add more" do
    visit meal_plan_assistant_path
    click_button "Something cozy"

    expect(page).to have_content("Here are some cozy ideas.")
    within(".meal-plan-assistant-suggestion", text: "Black Bean Chili") { click_button "+ Add" }

    within("#assistant_tray") do
      expect(page).to have_content("Black Bean Chili (serves 6)")
      expect(page).to have_content("1 recipe · 6 servings")
    end
    within(".meal-plan-assistant-suggestion", text: "Black Bean Chili") { expect(page).to have_button("Added", disabled: true) }

    meal_plan = user.reload.meal_plans.sole
    expect(meal_plan.recipes).to eq([chili])

    within("#assistant_tray") { click_link "View meal plan" }
    expect(page).to have_current_path(meal_plan_path(meal_plan))

    page.go_back

    expect(page).to have_content("Here are some cozy ideas.")
    within(".meal-plan-assistant-suggestion", text: "Black Bean Chili") { expect(page).to have_button("Added", disabled: true) }
    within(".meal-plan-assistant-suggestion", text: "Sesame Noodles") { click_button "+ Add" }

    within("#assistant_tray") { expect(page).to have_content("2 recipes · 10 servings") }
    expect(meal_plan.reload.recipes).to contain_exactly(chili, noodles)

    within("#assistant_tray li", text: "Black Bean Chili") { click_button "Remove" }

    within("#assistant_tray") { expect(page).not_to have_content("Black Bean Chili") }
    within(".meal-plan-assistant-suggestion", text: "Black Bean Chili") { expect(page).to have_button("+ Add", disabled: false) }
    expect(meal_plan.reload.recipes).to eq([noodles])
  end

  scenario "follow-up messages include the meal plan's recipes and the conversation so far" do
    visit meal_plan_assistant_path
    click_button "Something cozy"
    within(".meal-plan-assistant-suggestion", text: "Black Bean Chili") { click_button "+ Add" }
    within("#assistant_tray") { expect(page).to have_content("Black Bean Chili") }

    fill_in "message", with: "Something lighter"
    click_button "Ask"

    expect(page).to have_content("Something lighter")
    expect(MealPlanAssistant).to have_received(:reply).with(
      hash_including(message: "Something lighter", tray_recipe_ids: [chili.id], history: reply.history.map(&:stringify_keys))
    )
  end
end
