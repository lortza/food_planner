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
        expect(Ingredient::UNITS).to include(ingredient.measurement_unit)

        ingredient.measurement_unit = invalid_unit
        expect(Ingredient::UNITS).to_not include(ingredient.measurement_unit)
      end
    end

    context 'a valid preparation_style' do
      let(:invalid_style) { 'invalid style' }

      it 'must not be blank' do
        ingredient.preparation_style = nil
        expect(ingredient).to_not be_valid
      end

      it 'must be one from the list of styles' do
        expect(Ingredient::STYLES).to include(ingredient.preparation_style)

        ingredient.preparation_style = invalid_style
        expect(Ingredient::STYLES).to_not include(ingredient.preparation_style)
      end
    end
  end
end
