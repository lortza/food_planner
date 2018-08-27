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

    context 'when it does not have a source_name' do
      xit 'is not valid' do
        recipe.source_name = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a source_url' do
      xit 'is not valid' do
        recipe.source_url = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a servings' do
      it 'is not valid' do
        recipe.servings = nil
        expect(recipe).to_not be_valid
      end
    end

    context 'when it does not have a instructions' do
      it 'is not valid' do
        recipe.instructions = nil
        expect(recipe).to_not be_valid
      end
    end
  end
end
