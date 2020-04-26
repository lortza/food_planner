# frozen_string_literal: true

RSpec.describe ShoppingListItemBuilder, type: :model do
  let(:shopping_list) { create(:shopping_list) }
  let(:meal_plan) { create(:meal_plan) }
  let(:recipe) { create(:recipe) }
  let(:ingredient) { create(:ingredient, recipe: recipe, quantity: 1, measurement_unit: 'cup', name: 'rice') }
  let(:ingredients) { create_list(:ingredient, 3) }
  let(:ingredient_ids) { ingredient.id }

  describe 'self.create_shopping_list_item' do
    context 'when the item is already active on the list' do
      xit 'adds the incoming quantity to the existing quantity' do
      end
    end

    context 'when the item is already inactive on the list' do
      xit 'sets the item quantity to the incoming quantity' do
      end

      xit 'sets the item to active' do
      end
    end

    context 'when the item is already in_cart on the list' do
      xit 'does not modity the quantity' do
      end

      xit 'does not modify the status' do
      end
    end

    context 'when the item is not on the list' do
      xit 'creates a new the item' do
      end

      xit 'sets the item to active' do
      end

      xit 'sets the quantity to the incoming quantity' do
      end
    end
  end

  describe '#add_items_to_list' do
    let(:builder) do
      ShoppingListItemBuilder.new(
        shopping_list_id: shopping_list.id,
        ingredient_ids: ingredient_ids
      )
    end

    context 'when passed an array' do
      let(:ingredient_ids) { ingredients.pluck(:id) }
      it 'adds all ingredients as shopping_list_items on the given shopping_list' do
        builder.add_items_to_list
        expected_list_items = ingredients.map(&:measurement_and_name)
        actual_list_items = shopping_list.shopping_list_items.map(&:name)

        expect(expected_list_items).to eq(actual_list_items)
      end
    end

    context 'when passed a single ingredient' do
      it 'adds all ingredients as shopping_list_items on the given shopping_list' do
        builder.add_items_to_list
        expected_list_items = [ingredient].map(&:measurement_and_name)
        actual_list_items = shopping_list.shopping_list_items.map(&:name)

        expect(expected_list_items).to eq(actual_list_items)
      end
    end

    context 'when an ingredient is new to the shopping list' do
      it 'the list item quantity equals the ingredient quantity' do
        builder.add_items_to_list
        item = shopping_list.items.last

        expect(item.quantity).to eq(ingredient.quantity)
      end

      it 'is not crossed off' do
        builder.add_items_to_list
        item = shopping_list.items.last

        expect(item.purchased).to eq(false)
        expect(item.active?).to eq(true)
      end

      it 'assigns the list item to the "Unassigned" aisle' do
        builder.add_items_to_list
        item = shopping_list.items.last

        expect(item.aisle.name).to eq('unassigned')
      end
    end

    context 'when an ingredient is already on the shopping list' do
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
          builder.add_items_to_list

          item = shopping_list.items.last
          expect(item.aisle.name).to eq('unassigned')

          # assign an aisle to the item
          item.update!(aisle: aisle)

          # add the item for the second time
          builder.add_items_to_list

          expect(item.aisle.name).to eq('rice aisle')
        end
      end

      context 'and not marked as crossed-off' do
        it "the incoming ingredient's quantity is added to the list item's quantity" do
          # add item for the first time
          builder.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # add the item for the second time
          builder.add_items_to_list
          item.reload

          expect(item.quantity).to eq(2)
        end
      end

      context 'and marked as crossed-off' do
        it "the list item's quantity matches the incoming ingredient.quantity" do
          # add item for the first time
          builder.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # cross off the item
          item.update!(purchased: true, status: 'inactive')
          item.reload

          # add the item for the second time
          builder.add_items_to_list
          item.reload

          expect(item.quantity).to eq(ingredient.quantity)
        end

        it 'is no longer crossed off' do
          # add item for the first time
          builder.add_items_to_list

          item = shopping_list.items.last
          expect(item.quantity).to eq(1)

          # cross off the item
          item.update!(purchased: true, status: 'inactive')
          item.reload

          # add the item for the second time
          builder.add_items_to_list
          item.reload

          expect(item.active?).to eq(true)
        end
      end
    end
  end
end
