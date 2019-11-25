# frozen_string_literal: true

class ShoppingListItemBuilder
  attr_reader :shopping_list, :ingredients

  def initialize(shopping_list_id:, ingredient_ids:)
    @shopping_list = ShoppingList.find_by(id: shopping_list_id)
    @ingredients = Ingredient.where(id: ingredient_ids)
  end

  def add_items_to_list
    self.ingredients.each do |ingredient|
      add_ingredient_to_list(ingredient)
    end
  end

  private

  def add_ingredient_to_list(ingredient)
    item_on_list = self.shopping_list.shopping_list_items.find_by(name: ingredient.measurement_and_name)
    incoming_quantity = ingredient.quantity

    if item_on_list.nil?
      ShoppingListItem.create!(
        shopping_list_id: shopping_list.id,
        aisle_id: unassigned_aisle.id,
        quantity: incoming_quantity,
        name: ingredient.measurement_and_name,
        purchased: false
      )
    elsif item_on_list.purchased?
      item_on_list.update!(
        quantity: incoming_quantity,
        purchased: false
      )
    else
      item_on_list.quantity += incoming_quantity
      item_on_list.save
    end
  end

  def unassigned_aisle
    Aisle.unassigned(shopping_list)
  end
end
