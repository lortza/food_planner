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
end
