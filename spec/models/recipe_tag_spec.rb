# frozen_string_literal: true

# == Schema Information
#
# Table name: recipe_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :bigint           not null
#  tag_id     :bigint           not null
#
# Indexes
#
#  index_recipe_tags_on_recipe_id             (recipe_id)
#  index_recipe_tags_on_recipe_id_and_tag_id  (recipe_id,tag_id) UNIQUE
#  index_recipe_tags_on_tag_id                (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#  fk_rails_...  (tag_id => tags.id)
#
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
