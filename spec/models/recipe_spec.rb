# frozen_string_literal: true

RSpec.describe Recipe, type: :model do
  let(:recipe) { build(:recipe) }

  describe 'a valid recipe' do
    context 'when has valid params' do
      it 'is valid' do
        expect(recipe).to be_valid
      end
    end

    context 'when it does not have a title' do
      it 'is not valid' do
        recipe.title = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a source' do
      let(:recipe_missing_source) { create(:recipe, source_name: '', source_url: '') }

      it 'is provided a source name' do
        expect(recipe_missing_source.source_name).to eq(Recipe::DEFAULT_SOURCE[:source_name])
      end

      it 'is provided a source url' do
        expect(recipe_missing_source.source_url).to eq(Recipe::DEFAULT_SOURCE[:source_url])
      end
    end

    context 'when it does not have servings' do
      it 'is not valid' do
        recipe.servings = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have instructions' do
      it 'is not valid' do
        recipe.instructions = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a prep_time' do
      it 'is not valid' do
        recipe.prep_time = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a cook_time' do
      it 'is not valid' do
        recipe.cook_time = nil
        expect(recipe).to_not be_valid
      end
    end
  end

  describe '#last_prepared' do
    let(:meal_plan_today) { create(:meal_plan, start_date: Time.zone.today) }
    let(:meal_plan_yesterday) { create(:meal_plan, start_date: Time.zone.yesterday) }
    let(:recipe) { create(:recipe) }

    it 'returns the start_date of the most recent meal plan this recipe was included in' do
      meal_plan_today.recipes << recipe
      meal_plan_yesterday.recipes << recipe

      expect(recipe.last_prepared).to eq(meal_plan_today.start_date)
    end
  end

  describe '#total_time' do
    it 'adds the prep and cook times together' do
      recipe.prep_time = 1
      recipe.cook_time = 1
      expect(recipe.total_time).to eq(2)
    end
  end
end
