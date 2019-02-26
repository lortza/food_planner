# frozen_string_literal: true

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { build(:ingredient) }

  describe 'a valid ingredient' do
    context 'when has valid params' do
      it 'is valid' do
        expect(ingredient).to be_valid
      end

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:measurement_unit) }
      it { should validate_inclusion_of(:measurement_unit).in_array(Ingredient::UNITS) }
    end


    context 'a valid preparation_style' do
      let(:invalid_style) { 'invalid style' }

      it 'may be blank' do
        ingredient.preparation_style = nil
        expect(ingredient).to be_valid
      end

      xit 'must be one from the list of styles' do
        ingredient.preparation_style = Ingredient::STYLES.sample
        expect(ingredient).to be_valid

        ingredient.preparation_style = invalid_style
        expect(ingredient).to_not be_valid
      end
    end
  end
end
