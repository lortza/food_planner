# frozen_string_literal: true

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { build(:ingredient) }

  describe 'a valid ingredient' do
    context 'when has valid params' do
      it 'is valid' do
        expect(ingredient).to be_valid
      end
    end

    context 'when it does not have a recipe' do
      it 'is not valid' do
        ingredient.recipe_id = nil
        expect(ingredient).to_not be_valid
      end
    end

    context 'when it does not have a name' do
      it 'is not valid' do
        ingredient.name = nil
        expect(ingredient).to_not be_valid
      end
    end

    context 'when it does not have a quantity' do
      it 'is not valid' do
        ingredient.quantity = nil
        expect(ingredient).to_not be_valid
      end
    end

    context 'a valid measurement_unit' do
      let(:invalid_unit) { 'invalid unit' }
      it 'must not be blank' do
        ingredient.measurement_unit = nil
        expect(ingredient).to_not be_valid
      end

      it 'must be one from the list of units' do
        ingredient.measurement_unit = Ingredient::UNITS.sample
        expect(ingredient).to be_valid

        ingredient.measurement_unit = invalid_unit
        expect(ingredient).to_not be_valid
      end
    end

    context 'a valid preparation_style' do
      let(:invalid_style) { 'invalid style' }

      it 'may be blank' do
        ingredient.preparation_style = nil
        expect(ingredient).to be_valid
      end

      it 'must be one from the list of styles' do
        ingredient.preparation_style = Ingredient::STYLES.sample
        expect(ingredient).to be_valid

        ingredient.preparation_style = invalid_style
        expect(ingredient).to_not be_valid
      end
    end
  end
end
