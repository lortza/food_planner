# frozen_string_literal: true

class ShoppingListItemManager
  def initialize(shopping_list:, ingredients:)
    @shopping_list = shopping_list
    @ingredients = ingredients
  end

  def add_ingredient_to_list(ingredient)
    item_name = "#{ingredient.measurement_unit} #{ingredient.name}"
    item = @shopping_list.shopping_list_items.find_by(name: item_name)
    incoming_quantity = ingredient.quantity

    if item.nil?
      ShoppingListItem.create!(
        shopping_list_id: @shopping_list.id,
        aisle_id: unassigned_aisle.id,
        quantity: incoming_quantity,
        name: item_name,
        purchased: false
      )
    elsif item.purchased?
      item.update!(
        quantity: incoming_quantity,
        purchased: false
      )
    else
      item.quantity += incoming_quantity
      item.save
    end
  end

  def add_items_to_list
    @ingredients.each do |ingredient|
      add_ingredient_to_list(ingredient)
    end
  end

  private

  def unassigned_aisle
    Aisle.unassigned(@shopping_list)
  end
end
