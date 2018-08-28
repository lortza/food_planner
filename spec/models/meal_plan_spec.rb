# frozen_string_literal: true

RSpec.describe MealPlan, type: :model do
  let(:meal_plan) { build(:meal_plan) }

  describe 'a valid meal_plan' do
    context 'when has valid params' do
      it 'is valid' do
        expect(meal_plan).to be_valid
      end
    end

    context 'when it does not have a start_date' do
      it 'is not valid' do
        meal_plan.start_date = nil
        expect(meal_plan).to_not be_valid
      end
    end

    context 'when it does not have a people_served' do
      it 'is not valid' do
        meal_plan.people_served = nil
        expect(meal_plan).to_not be_valid
      end
    end
  end

  describe 'self.ordered' do
    it 'displays all meal plans in descending start_date order' do
      meal_plan1 = create(:meal_plan, start_date: Time.zone.yesterday)
      meal_plan2 = create(:meal_plan, start_date: Time.zone.today)

      expect(MealPlan.ordered.first).to eq(meal_plan2)
      expect(MealPlan.ordered.last).to eq(meal_plan1)
    end
  end

  describe '#total_servings' do
    let(:standard_servings) { 2 }
    let(:qty_recipes) { 2 }

    it 'returns a total of servings for all recipes in meal plan' do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, servings: standard_servings)
        meal_plan.save
      end
      expect(meal_plan.total_servings).to eq(standard_servings * qty_recipes)
    end
  end

  describe '#total_prep_time' do
    let(:standard_prep_time) { 2 }
    let(:qty_recipes) { 2 }

    it 'returns a prep time total for all recipes in meal plan' do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, prep_time: standard_prep_time)
        meal_plan.save
      end
      expect(meal_plan.total_prep_time).to eq(standard_prep_time * qty_recipes)
    end
  end

  describe '#total_cook_time' do
    let(:standard_cook_time) { 2 }
    let(:qty_recipes) { 2 }

    it 'returns a cook time total for all recipes in meal plan' do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, cook_time: standard_cook_time)
        meal_plan.save
      end

      expect(meal_plan.total_cook_time).to eq(standard_cook_time * qty_recipes)
    end
  end

  describe '#total_time' do
    let(:standard_cook_time) { 2 }
    let(:standard_prep_time) { 2 }
    let(:qty_recipes) { 2 }
    let(:total_standard_time) { (standard_cook_time + standard_prep_time) * qty_recipes }

    it 'returns a time total for all recipes in meal plan' do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, prep_time: standard_prep_time, cook_time: standard_cook_time)
        meal_plan.save
      end

      expect(meal_plan.total_time).to eq(total_standard_time)
    end
  end

  describe '#meals' do
    let(:standard_servings) { 2 }
    let(:qty_recipes) { 2 }
    let(:total_servings) { standard_servings * qty_recipes }
    let(:expected_qty) { total_servings / meal_plan.people_served }

    it 'returns the number of servings for recipes divided by people served in a meal plan' do
      qty_recipes.times do
        meal_plan.recipes << create(:recipe, servings: standard_servings)
        meal_plan.save
      end
      expect(meal_plan.meals).to eq(expected_qty)
    end
  end

  describe '#total_unique_ingredients' do
    let(:qty_recipes) { 2 }
    let(:recipe1) { create(:recipe) }
    let(:recipe2) { create(:recipe) }
    let(:ingredient1) { build(:ingredient) }
    let(:ingredient2) { build(:ingredient) }

    it 'returns a count of all unique ingredients used in meal plan' do
      recipe1.ingredients << ingredient1
      recipe1.save

      recipe2.ingredients << [ingredient1, ingredient2]
      recipe2.save

      meal_plan.recipes << [recipe1, recipe2]
      meal_plan.save
      expect(meal_plan.total_unique_ingredients).to eq(2)
    end
  end
end
