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
      let(:shopping_list) { create(:shopping_list) }
      let(:meal_plan) { create(:meal_plan) }
      let(:recipe) { create(:recipe) }
      let(:ingredient) { create(:ingredient, recipe: recipe, quantity: 1, measurement_unit: 'cup', name: 'rice') }

      it 'the list item quantity equals the ingredient quantity' do
        meal_plan.recipes << recipe
        recipe.ingredients << ingredient

        manager = BulkListItemManager.new(
          shopping_list: shopping_list,
          items_source: meal_plan
        )
        manager.add_items_to_list
        item = shopping_list.items.last

        expect(item.quantity).to eq(ingredient.quantity)
      end

      it 'is not crossed off' do
        meal_plan.recipes << recipe
        recipe.ingredients << ingredient

        manager = BulkListItemManager.new(
          shopping_list: shopping_list,
          items_source: meal_plan
        )
        manager.add_items_to_list
        item = shopping_list.items.last

        expect(item.purchased).to eq(false)
      end

      it 'assigns the list item to the "Unassigned" aisle' do
        meal_plan.recipes << recipe
        recipe.ingredients << ingredient

        manager = BulkListItemManager.new(
          shopping_list: shopping_list,
          items_source: meal_plan
        )
        manager.add_items_to_list
        item = shopping_list.items.last

        expect(item.aisle.name).to eq('unassigned')
      end
    end

    context 'when an ingredient is already on the shopping list' do
      let(:user) { create(:user) }
      let(:meal_plan) { create(:meal_plan, user: user) }
      let(:recipe) { create(:recipe, user: user) }
      let(:ingredient) { create(:ingredient, recipe: recipe, quantity: 1, measurement_unit: 'cup', name: 'rice') }
      let(:aisle) { create(:aisle, user: user, name: 'rice aisle') }
      let(:shopping_list) { create(:shopping_list, user: user) }
      let(:shopping_list_item) { create(:shopping_list_item, shopping_list: shopping_list, name: 'cup rice') }

      context 'and has an aisle assigned' do
        it 'does not change that aisle assignment' do
          meal_plan.recipes << recipe
          recipe.ingredients << ingredient

          manager = BulkListItemManager.new(
            shopping_list: shopping_list,
            items_source: meal_plan
          )
          # add item for the first time
          manager.add_items_to_list

          item = shopping_list.items.last
          expect(item.aisle.name).to eq('unassigned')

          #assign an aisle to the item
          item.update!(aisle: aisle)

          # add the item for the second time
          manager.add_items_to_list

          expect(item.aisle.name).to eq('rice aisle')
        end
      end

      context 'and not marked as crossed-off' do
        it "the incoming ingredient's quantity is added to the list item's quantity" do
          meal_plan.recipes << recipe
          recipe.ingredients << ingredient

          manager = BulkListItemManager.new(
            shopping_list: shopping_list,
            items_source: meal_plan
          )
          # add item for the first time
          manager.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # add the item for the second time
          manager.add_items_to_list
          item.reload

          expect(item.quantity).to eq(2)
        end
      end

      context 'and marked as crossed-off' do
        it "the list item's quantity matches the incoming ingredient.quantity" do
          meal_plan.recipes << recipe
          recipe.ingredients << ingredient

          manager = BulkListItemManager.new(
            shopping_list: shopping_list,
            items_source: meal_plan
          )
          # add item for the first time
          manager.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # cross off the item
          item.update!(purchased: true)
          item.reload

          # add the item for the second time
          manager.add_items_to_list
          item.reload

          expect(item.quantity).to eq(ingredient.quantity)
        end

        it 'is no longer crossed off' do
          meal_plan.recipes << recipe
          recipe.ingredients << ingredient

          manager = BulkListItemManager.new(
            shopping_list: shopping_list,
            items_source: meal_plan
          )
          # add item for the first time
          manager.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # cross off the item
          item.update!(purchased: true)
          item.reload

          # add the item for the second time
          manager.add_items_to_list
          item.reload

          expect(item.purchased).to eq(false)
        end
      end
    end
  end
end
