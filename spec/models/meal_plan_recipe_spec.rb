# frozen_string_literal: true

RSpec.describe MealPlanRecipe, type: :model do
  context 'associations' do
    it { should belong_to(:meal_plan) }
    it { should belong_to(:recipe) }
  end

  context 'validations' do
    it { should validate_presence_of(:meal_plan_id) }
    it { should validate_presence_of(:recipe_id) }
    
    it { should validate_uniqueness_of(:recipe_id).scoped_to(:meal_plan_id) }
  end
end
