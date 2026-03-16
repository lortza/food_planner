# frozen_string_literal: true

# == Schema Information
#
# Table name: meal_plan_recipes
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  meal_plan_id :bigint
#  recipe_id    :bigint
#
# Indexes
#
#  index_meal_plan_recipes_on_meal_plan_id  (meal_plan_id)
#  index_meal_plan_recipes_on_recipe_id     (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (meal_plan_id => meal_plans.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
RSpec.describe MealPlanRecipe, type: :model do
  context "associations" do
    it { should belong_to(:meal_plan) }
    it { should belong_to(:recipe) }
  end

  context "validations" do
    it "is valid" do
      expect(meal_plan_recipe).to be_valid
    end

    # Must create instance of meal_plan_recipe for uniqueness test to work
    let!(:meal_plan_recipe) { create(:meal_plan_recipe) }
    it { should validate_uniqueness_of(:recipe_id).scoped_to(:meal_plan_id) }
  end
end
