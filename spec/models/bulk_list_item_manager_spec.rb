# frozen_string_literal: true

RSpec.describe BulkListItemManager, type: :model do
  describe '#add_items_to_list' do
    let(:shopping_list) { create(:shopping_list) }
    let(:meal_plan) { create(:meal_plan) }
    let(:recipe1) { create(:recipe, :with_2_ingredients) }
    let(:recipe2) { create(:recipe, :with_2_ingredients) }

    it 'adds all ingredients as shopping_list_items on the given shopping_list' do
      meal_plan.recipes << [recipe1, recipe2]
      manager = BulkListItemManager.new(
        shopping_list: shopping_list,
        items_source: meal_plan
      )
      manager.add_items_to_list
      expected_list_items = meal_plan.ingredients.map { |ingredient| "#{ingredient.measurement_unit} #{ingredient.name}" }
      actual_list_items = shopping_list.shopping_list_items.map(&:name)

      expect(expected_list_items).to eq(actual_list_items)
    end

    context 'when an ingredient is new to the shopping list' do
      xit 'the list item quantity equals the ingredient quantity' do
      end

      xit 'is not crossed off' do
      end

      xit 'assigns the list item to the "Unassigned" aisle' do
      end
    end

    context 'when an ingredient is already on the shopping list and has an aisle assigned' do
      xit 'does not change that aisle assignment' do
      end
    end

    context 'when an ingredient is already on the shopping list and not marked as crossed-off' do
      xit "the incoming ingredient's quantity is added to the list item's quantity" do
      end
    end

    context 'when an ingredient is already on the shopping list and marked as crossed-off' do
      xit "the list item's quantity matches the incoming ingredient.quantity" do
      end

      xit 'is no longer crossed off' do
      end
    end
  end
end
