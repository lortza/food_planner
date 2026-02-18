# frozen_string_literal: true

require "rails_helper"

RSpec.describe "recipes/index.html.erb", type: :view do
  let(:user) { create(:user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
  end

  describe "displaying tags" do
    context "when the user has custom tags" do
      let(:tag_zucchini) { create(:tag, name: "zucchini", user: user) }
      let(:tag_apple) { create(:tag, name: "apple", user: user) }

      before do
        tag_zucchini
        tag_apple
        assign(:recipes, WillPaginate::Collection.create(1, 30, 0) { |p| p.replace([]) })
        render
      end

      it "has a link to 'all' recipes" do
        expect(rendered).to have_link("all", href: recipes_path, visible: :all)
      end

      it "displays a list of tags in alphabetical order" do
        expect(rendered).to have_link("apple", visible: :all)
        expect(rendered).to have_link("zucchini", visible: :all)
        expect(rendered.index("apple")).to be < rendered.index("zucchini")
      end
    end

    context "when the user has no custom tags" do
      before do
        assign(:recipes, WillPaginate::Collection.create(1, 30, 0) { |p| p.replace([]) })
        render
      end

      it "has a link to 'all' recipes" do
        expect(rendered).to have_link("all", href: recipes_path, visible: :all)
      end

      it "displays no tags" do
        expect(rendered).to have_selector("a.badge", count: 1, visible: :all)
      end
    end
  end

  describe "displaying recipes" do
    context "when there are recipes present" do
      let(:recipe) { create(:recipe, user: user) }

      before do
        recipe
        collection = WillPaginate::Collection.create(1, 30, 1) { |pager| pager.replace([recipe]) }
        assign(:recipes, collection)
        render
      end

      it "displays the recipes" do
        expect(rendered).to have_text(recipe.title)
      end
    end

    context "when there are no recipes" do
      before do
        assign(:recipes, WillPaginate::Collection.create(1, 30, 0) { |p| p.replace([]) })
        render
      end

      it "displays a message indicating there are no recipes" do
        expect(rendered).to have_text("There are no recipes")
      end
    end
  end

  describe "pagination" do
    context "when there are more recipes than fit on one page" do
      before do
        recipes = create_list(:recipe, 30, user: user)
        collection = WillPaginate::Collection.create(1, 30, 31) { |pager| pager.replace(recipes) }
        assign(:recipes, collection)
        render
      end

      it "displays pagination controls" do
        expect(rendered).to have_selector(".pagination")
      end
    end

    context "when there are only enough recipes to fill one page" do
      before do
        recipe = create(:recipe, user: user)
        collection = WillPaginate::Collection.create(1, 30, 1) { |pager| pager.replace([recipe]) }
        assign(:recipes, collection)
        render
      end

      it "does not display pagination controls" do
        expect(rendered).not_to have_selector(".pagination")
      end
    end
  end
end
