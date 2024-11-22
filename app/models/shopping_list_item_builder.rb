# frozen_string_literal: true

class ShoppingListItemBuilder
  class << self
    def add_item_to_list(shopping_list:, incoming_item:)
      existing_item = shopping_list.items.find_by(name: incoming_item.name)

      if existing_item&.active? || existing_item&.in_cart?
        updated_quantity = existing_item.quantity + incoming_item.quantity
        existing_item.update(quantity: updated_quantity)
      elsif existing_item&.inactive?
        existing_item.update(quantity: incoming_item.quantity, status: "active")
      else
        incoming_item.status = "active"
        shopping_list.items << incoming_item
      end
    end

    def add_ingredients_to_list(shopping_list:, ingredient_ids:)
      ingredients = Ingredient.where(id: ingredient_ids)

      ingredients.each do |ingredient|
        item = shopping_list.items.new(
          aisle_id: Aisle.unassigned(shopping_list).id,
          quantity: ingredient.quantity,
          name: ingredient.measurement_and_name,
          status: "active"
        )
        add_item_to_list(shopping_list: shopping_list, incoming_item: item)
      end
    end
  end
end
