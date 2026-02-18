# frozen_string_literal: true

RSpec.describe Ingredient, type: :model do
  let(:ingredient) { build(:ingredient) }

  context "associations" do
    it { should belong_to(:recipe) }
  end

  describe "normalization" do
    it "strips leading/trailing whitespace and squishes internal whitespace in the name" do
      ingredient = build(:ingredient, name: "  Example    Ingredient  ")
      expect(ingredient.valid?).to be(true)
      expect(ingredient.name).to eq("Example Ingredient")
    end

    it "does not affect case" do
      ingredient = build(:ingredient, name: "  ExAmPlE    iNGREdiENT  ")
      expect(ingredient.valid?).to be(true)
      expect(ingredient.name).to eq("ExAmPlE iNGREdiENT")
    end
  end

  describe "a valid ingredient" do
    context "when has valid params" do
      it "is valid" do
        expect(ingredient).to be_valid
      end

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:measurement_unit) }
      it { should validate_inclusion_of(:measurement_unit).in_array(Ingredient::UNITS) }
    end

    context "quantity" do
      it "is valid with a float" do
        ingredient.quantity = "0.0222"
        expect(ingredient.valid?).to be true
      end

      it "is valid with an integer" do
        ingredient.quantity = "2"
        expect(ingredient.valid?).to be true
      end

      it "is valid with a space" do
        ingredient.quantity = "    0.2222   "
        expect(ingredient.valid?).to be true
      end

      it "is invalid with a non-number" do
        ingredient.quantity = "tacos"
        expect(ingredient.valid?).to be false
      end
    end

    context "a valid preparation_style" do
      let(:invalid_style) { "invalid style" }

      it "may be blank" do
        ingredient.preparation_style = nil
        expect(ingredient).to be_valid
      end
    end
  end
end
