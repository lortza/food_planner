# frozen_string_literal: true

RSpec.describe RecipeTag, type: :model do
  context "associations" do
    it { should belong_to(:recipe) }
    it { should belong_to(:tag) }
  end

  context "validations" do
    it "is valid" do
      expect(recipe_tag).to be_valid
    end

    # Must create instance of recipe_tag for uniqueness test to work
    let!(:recipe_tag) { create(:recipe_tag, tag: tag, recipe: recipe) }
    let(:user) { create(:user) }
    let(:tag) { create(:tag, user: user) }
    let(:recipe) { create(:recipe, user: user) }
    it { should validate_uniqueness_of(:recipe_id).scoped_to(:tag_id) }
  end
end
