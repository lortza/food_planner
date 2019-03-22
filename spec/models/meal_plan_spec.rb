# frozen_string_literal: true

RSpec.describe MealPlan, type: :model do
  let(:meal_plan) { build(:meal_plan) }

  describe 'a valid meal_plan' do
    context 'when has valid params' do
      it 'is valid' do
        expect(meal_plan).to be_valid
      end
    end

    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:people_served) }
  end

  describe 'self.most_recent_first' do
    it 'displays all meal plans in descending start_date order' do
      meal_plan1 = create(:meal_plan, start_date: Time.zone.yesterday)
      meal_plan2 = create(:meal_plan, start_date: Time.zone.today)

      expect(MealPlan.most_recent_first.first).to eq(meal_plan2)
      expect(MealPlan.most_recent_first.last).to eq(meal_plan1)
    end
  end

  describe 'self.date_for_upcoming_sunday' do
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

  describe '#estimated_time' do
    let(:meal_plan) { create(:meal_plan) }

    it 'will output a time shorter than the total cook time' do
      minutes = 100
      rate = 0.5
      est_time = 50
      allow(meal_plan).to receive(:total_time).and_return(minutes)
      allow(meal_plan).to receive(:efficiency_rate).and_return(rate)

      expect(meal_plan.estimated_time).to be < meal_plan.total_time
      expect(meal_plan.estimated_time).to eq(est_time)
    end
  end

  describe '#recommended_start_time' do
    let(:meal_plan) { create(:meal_plan) }

    it 'outputs in time format' do
      time = '12:00 PM'.to_time
      est_minutes = 60
      expected_time = '11:00 AM'.to_time.strftime('%I:%M %p')
      allow(meal_plan).to receive(:prep_end_time).and_return(time)
      allow(meal_plan).to receive(:estimated_time).and_return(est_minutes)

      expect(meal_plan.recommended_start_time).to eq(expected_time)
    end

    xit 'will never be later than MealPlan::PREP_END_TIME' do
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
