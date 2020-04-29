# frozen_string_literal: true

RSpec.describe ShoppingListItemBuilder, type: :model do
  describe 'self.add_item_to_list' do
    context 'when the item is not on the list' do
      let(:shopping_list) { create(:shopping_list, main: true) }
      let(:incoming_item) { build(:shopping_list_item, shopping_list: shopping_list) }

      before do
        ShoppingListItemBuilder.add_item_to_list(shopping_list: shopping_list,
                                                 incoming_item: incoming_item)
      end

      it 'creates a new the item' do
        expect(shopping_list.items.count).to eq(1)
      end

      it 'sets the item to active' do
        item = shopping_list.items.first
        expect(item.active?).to be true
      end

      it 'sets the quantity to the incoming quantity' do
        incoming_quantity = incoming_item.quantity
        item = shopping_list.items.first

        expect(item.quantity).to eq(incoming_quantity)
      end
    end

    context 'when the item is already active on the list' do
      let(:shopping_list_item) { create(:shopping_list_item, status: 'active', quantity: 2) }
      let(:shopping_list) { shopping_list_item.shopping_list }
      let(:incoming_item) { build(:shopping_list_item, shopping_list: shopping_list, quantity: 2, name: shopping_list_item.name) }

      before do
        ShoppingListItemBuilder.add_item_to_list(shopping_list: shopping_list,
                                                 incoming_item: incoming_item)
      end

      it 'adds the incoming quantity to the existing quantity' do
        item = shopping_list.items.first
        expect(item.quantity).to eq(4)
      end
    end

    context 'when the item is already inactive on the list' do
      let(:shopping_list_item) { create(:shopping_list_item, status: 'inactive', quantity: 5) }
      let(:shopping_list) { shopping_list_item.shopping_list }
      let(:incoming_item) { build(:shopping_list_item, shopping_list: shopping_list, quantity: 1, name: shopping_list_item.name) }

      before do
        ShoppingListItemBuilder.add_item_to_list(shopping_list: shopping_list,
                                                 incoming_item: incoming_item)
      end

      it 'sets the item quantity to the incoming quantity' do
        item = shopping_list.items.first
        expect(item.quantity).to eq(incoming_item.quantity)
      end

      it 'sets the item to active' do
        item = shopping_list.items.first
        expect(item.active?).to be(true)
      end
    end

    context 'when the item is already in_cart on the list' do
      let(:shopping_list_item) { create(:shopping_list_item, status: 'in_cart', quantity: 5) }
      let(:shopping_list) { shopping_list_item.shopping_list }
      let(:incoming_item) { build(:shopping_list_item, shopping_list: shopping_list, quantity: 1, name: shopping_list_item.name) }

      before do
        ShoppingListItemBuilder.add_item_to_list(shopping_list: shopping_list,
                                                 incoming_item: incoming_item)
      end

      it 'adds the incoming quantity to the existing quantity' do
        item = shopping_list.items.first
        expect(item.quantity).to eq(6)
      end

      it 'does not modify the status' do
        item = shopping_list.items.first
        expect(item.status).to eq('in_cart')
      end
    end
  end





  describe '#add_ingredients_to_list' do
    let(:shopping_list) { create(:shopping_list, main: true) }
    # let(:meal_plan) { create(:meal_plan) }
    # let(:recipe) { create(:recipe) }
    # let(:ingredient) { create(:ingredient, recipe: recipe, quantity: 1, measurement_unit: 'cup', name: 'rice') }
    let(:ingredients) { create_list(:ingredient, 3) }
    # let(:ingredient_ids) { ingredient.id }
    let(:ingredient_ids) { ingredients.pluck(:id) }
    let!(:aisle) { create(:aisle, name: 'Unassigned') }

    context 'when passed an array' do
      it 'adds all ingredients as shopping_list_items on the given shopping_list' do
        described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)
        expected_list_items = ingredients.map(&:measurement_and_name)
        actual_list_items = shopping_list.shopping_list_items.map(&:name)

        expect(expected_list_items).to eq(actual_list_items)
      end
    end

    context 'when passed a single ingredient' do
      it 'adds all ingredients as shopping_list_items on the given shopping_list' do
        ingredient_ids = [ingredients.first.id]
        described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)

        expected_list_items = [ingredients.first.measurement_and_name]
        actual_list_items = shopping_list.shopping_list_items.map(&:name)

        expect(expected_list_items).to eq(actual_list_items)
      end
    end

    context 'when an ingredient is new to the shopping list' do
      it 'the list item quantity equals the ingredient quantity' do
        ingredient_ids = [ingredients.first.id]
        described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)
        item = shopping_list.items.first

        expect(item.quantity).to eq(ingredients.first.quantity)
      end

      it 'is not crossed off' do
        ingredient_ids = [ingredients.first.id]
        described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)
        item = shopping_list.items.first

        expect(item.active?).to eq(true)
      end

      it 'assigns the list item to the "Unassigned" aisle' do
        ingredient_ids = [ingredients.first.id]
        described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: ingredient_ids)
        item = shopping_list.items.first

        expect(item.aisle.name).to eq('unassigned')
      end
    end

    context 'when an ingredient is already on the shopping list' do
      let(:ingredient) { create(:ingredient) }
      let(:user) { create(:user) }
      let(:aisle) { create(:aisle, user: user, name: 'rice aisle') }
      let(:shopping_list) { create(:shopping_list, user: user) }
      let(:shopping_list_item) do
        create(
          :shopping_list_item,
          shopping_list: shopping_list,
          name: ingredient.measurement_and_name
        )
      end

      context 'and has an aisle assigned' do
        it 'does not change that aisle assignment' do
          # add item for the first time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item = shopping_list.items.last
          expect(item.aisle.name).to eq('unassigned')

          # assign an aisle to the item
          item.update!(aisle: aisle)

          # add the item for the second time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          expect(item.aisle.name).to eq('rice aisle')
        end
      end

      context 'and not marked as crossed-off' do
        it "the incoming ingredient's quantity is added to the list item's quantity" do
          # add item for the first time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item = shopping_list.items.last
          expect(item.quantity).to eq(ingredient.quantity)

          # add the item for the second time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item.reload
          expect(item.quantity).to eq(ingredient.quantity * 2)
        end
      end

      context 'and marked as crossed-off' do
        it "the list item's quantity matches the incoming ingredient.quantity" do
          # add item for the first time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item = shopping_list.items.last
          expect(item.quantity).to eq(ingredient.quantity)

          # cross off the item
          item.update!(status: 'inactive')
          item.reload

          # add the item for the second time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item.reload

          expect(item.quantity).to eq(ingredient.quantity)
        end

        it 'is no longer crossed off' do
          # add item for the first time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item = shopping_list.items.last
          expect(item.quantity).to eq(ingredient.quantity)

          # cross off the item
          item.update!(status: 'inactive')
          item.reload

          # add the item for the second time
          described_class.add_ingredients_to_list(shopping_list: shopping_list, ingredient_ids: [ingredient.id])
          item.reload

          expect(item.active?).to eq(true)
        end
      end
    end
  end
end
