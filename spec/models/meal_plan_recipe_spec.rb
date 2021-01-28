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

  context 'callback: after_save' do
    describe 'update_recipe_last_prepared_date' do
      it 'populates the recipe.last_prepared_on when a recipe is added to a plan' do
        meal_plan_date = '2021-01-20'.to_date
        recipe = create(:recipe)
        meal_plan = create(:meal_plan, prepared_on: meal_plan_date)
        expect(recipe.last_prepared_on).to be nil

        create(:meal_plan_recipe, recipe: recipe, meal_plan: meal_plan)
        recipe.reload
        expect(recipe.last_prepared_on).to eq(meal_plan_date)
      end

      it 'updates the recipe.last_prepared_on when a recipe is removed from a plan' do
        recipe = create(:recipe)
        last_month = '2020-12-20'.to_date
        last_month_meal_plan = create(:meal_plan, prepared_on: last_month)
        last_mpr = create(:meal_plan_recipe, recipe: recipe, meal_plan: last_month_meal_plan)
        this_month = '2021-01-20'.to_date
        this_month_meal_plan = create(:meal_plan, prepared_on: this_month)
        this_mpr = create(:meal_plan_recipe, recipe: recipe, meal_plan: this_month_meal_plan)

        recipe.reload
        expect(recipe.last_prepared_on).to eq(this_month)

        this_mpr.destroy
        recipe.reload
        expect(recipe.last_prepared_on).to eq(last_month)
      end

      it 'removes the recipe.last_prepared_on when a recipe is removed from all plans' do
        recipe = create(:recipe)
        date = '2021-01-20'.to_date
        meal_plan = create(:meal_plan, prepared_on: date)
        mpr = create(:meal_plan_recipe, recipe: recipe, meal_plan: meal_plan)

        recipe.reload
        expect(recipe.last_prepared_on).to eq(date)

        mpr.destroy
        recipe.reload
        expect(recipe.last_prepared_on).to be nil
      end
    end
  end
end
