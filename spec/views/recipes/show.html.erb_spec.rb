# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/show.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    assign(:recipe, recipe)
    allow(view).to receive(:current_user).and_return(user)
    permits_update = double("RecipePolicy", update?: true) # rubocop:disable RSpec/VerifiedDoubles
    view.define_singleton_method(:policy) { |_| permits_update }
  end

  it "displays the title" do
    render
    expect(rendered).to have_text(recipe.title)
  end

  describe "extra_work_required" do
    let(:extra_work_note_content) { "Requires extra chopping" }

    context "when there is an extra_work_required note and a current_user" do
      let(:recipe) { create(:recipe, user: user, extra_work_note: extra_work_note_content) }

      before { render }

      it "displays the extra_work_flag" do
        expect(rendered).to have_css("span.text-warning")
      end

      it "displays the extra_work_required note" do
        expect(rendered).to have_text(extra_work_note_content)
      end
    end

    context "when there is an extra_work_required note but no current_user" do
      let(:recipe) { create(:recipe, user: user, extra_work_note: extra_work_note_content) }

      before do
        allow(view).to receive(:current_user).and_return(nil)
        denies_update = double("RecipePolicy", update?: false) # rubocop:disable RSpec/VerifiedDoubles
        view.define_singleton_method(:policy) { |_| denies_update }
        render
      end

      it "does not display the extra_work_flag" do
        expect(rendered).not_to have_css("span.text-warning")
      end

      it "displays the extra_work_required note" do
        expect(rendered).to have_text(extra_work_note_content)
      end
    end

    context "when there is no extra_work_required note" do
      before { render }

      it "does not display the extra_work_flag" do
        expect(rendered).not_to have_css("span.text-warning")
      end

      it "does not display the extra_work_required note" do
        expect(rendered).not_to have_css(".alert.alert-warning")
      end
    end
  end

  it "displays a link to edit the recipe" do
    render
    expect(rendered).to have_link(href: edit_recipe_path(recipe))
  end

  it "displays the recipe source" do
    render
    expect(rendered).to have_link(recipe.source_name, href: recipe.source_url)
  end

  it "displays the recipe servings" do
    render
    expect(rendered).to have_text("Servings: #{recipe.servings}")
  end

  it "displays the recipe prep time" do
    render
    expect(rendered).to have_text("Prep Time:")
  end

  it "displays the recipe cook time" do
    render
    expect(rendered).to have_text("Cook Time:")
  end

  it "displays the recipe total time" do
    render
    expect(rendered).to have_text("Total Time:")
  end

  it "displays the recipe reheat time" do
    render
    expect(rendered).to have_text("Reheat Time:")
  end

  it "displays a count of how many times the recipe has been prepared" do
    render
    expect(rendered).to have_text("Prepared: 0 times")
  end

  context "when the recipe has tags" do
    let!(:tag) { create(:tag, name: "italian", user: user) }

    before do
      recipe.tags << tag
      render
    end

    it "displays the recipe's tags" do
      expect(rendered).to have_link("italian")
    end
  end

  context "when the recipe does not have tags" do
    before { render }

    it "does not display any tags" do
      expect(rendered).not_to have_css("a.badge")
    end
  end

  context "when there are recipe notes present" do
    let(:recipe) { create(:recipe, user: user, notes: "Make sure to let it rest") }

    before { render }

    it "displays the notes heading" do
      expect(rendered).to have_css("h5", text: "Notes")
    end

    it "displays the recipe notes" do
      expect(rendered).to have_text("Make sure to let it rest")
    end
  end

  context "when there are no recipe notes present" do
    let(:recipe) { create(:recipe, user: user, notes: nil) }

    before { render }

    it "does not display the notes heading" do
      expect(rendered).not_to have_css("h5", text: "Notes")
    end

    it "does not display the recipe notes" do
      expect(rendered).not_to have_css(".alert-warning")
    end
  end

  it "displays the recipe's ingredients" do
    create(:ingredient, recipe: recipe, name: "garlic")
    render
    expect(rendered).to have_text("garlic")
  end

  context "when the recipe update policy permits" do
    let(:user) { create(:user, :admin) }

    before do
      create(:shopping_list, user: user)
      create(:meal_plan, user: user)
      render
    end

    it "displays the option to add ingredients to the shopping list" do
      expect(rendered).to have_text("Add Ingredients to List:")
    end

    it "displays related meal_plans" do
      expect(rendered).to have_text("Related Meal Plans")
    end

    it "displays the option to copy the recipe for another user" do
      expect(rendered).to have_text("Copy Recipe for User")
    end

    it "displays related recipes" do
      expect(rendered).to include("Related Recipes")
    end
  end

  context "when the recipe update policy does not permit" do
    before do
      denies_update = double("RecipePolicy", update?: false) # rubocop:disable RSpec/VerifiedDoubles
      view.define_singleton_method(:policy) { |_| denies_update }
      render
    end

    it "does not display the option to add ingredients to the shopping list" do
      expect(rendered).not_to have_text("Add Ingredients to List:")
    end

    it "does not display related meal_plans" do
      expect(rendered).not_to have_text("Related Meal Plans")
    end

    it "does not display the option to copy the recipe for another user" do
      expect(rendered).not_to have_text("Copy Recipe for User")
    end

    it "does not display related recipes" do
      expect(rendered).not_to include("Related Recipes")
    end
  end
end
