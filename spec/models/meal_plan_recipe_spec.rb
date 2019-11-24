# frozen_string_literal: true

RSpec.describe MealPlanRecipe, type: :model do
  context 'associations' do
    it { should belong_to(:meal_plan) }
    it { should belong_to(:recipe) }
  end

  context 'validations' do
    it 'is valid' do
      expect(meal_plan_recipe).to be_valid
    end

    # Must create instance of meal_plan_recipe for uniqueness test to work
    let!(:meal_plan_recipe) { create(:meal_plan_recipe) }
    it { should validate_uniqueness_of(:recipe_id).scoped_to(:meal_plan_id) }
  end
end
