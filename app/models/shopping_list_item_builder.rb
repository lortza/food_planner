# frozen_string_literal: true

class ShoppingListItemBuilder
  attr_reader :shopping_list, :ingredients

  def initialize(shopping_list_id:, ingredient_ids:)
    @shopping_list = ShoppingList.find_by(id: shopping_list_id)
    @ingredients = Ingredient.where(id: ingredient_ids)
  end

  def self.create_shopping_list_item(shopping_list:, incoming_item:)
    existing_item = shopping_list.items.find_by(name: incoming_item.name)

    if existing_item.present?
      updated_quantity = existing_item.quantity + incoming_item.quantity
      updated_quantity = incoming_item.quantity if existing_item.inactive?

      existing_item.update(quantity: updated_quantity, purchased: false, status: 'active')
    else
      incoming_item.purchased = false
      incoming_item.status = 'active'
      shopping_list.items << incoming_item
    end
  end

  def add_items_to_list
    ingredients.each do |ingredient|
      add_ingredient_to_list(ingredient)
    end
  end

  private

  def add_ingredient_to_list(ingredient)
    item_on_list = shopping_list.shopping_list_items.find_by(name: ingredient.measurement_and_name)
    incoming_quantity = ingredient.quantity

    if item_on_list.nil?
      ShoppingListItem.create!(
        shopping_list_id: shopping_list.id,
        aisle_id: unassigned_aisle.id,
        quantity: incoming_quantity,
        name: ingredient.measurement_and_name,
        purchased: false,
        status: 'active'
      )
    elsif item_on_list.inactive?
      item_on_list.update!(
        quantity: incoming_quantity,
        purchased: false,
        status: 'active'
      )
    else # if item on list is active
      item_on_list.quantity += incoming_quantity
      item_on_list.save
    end
  end

  def unassigned_aisle
    Aisle.unassigned(shopping_list)
  end
end
