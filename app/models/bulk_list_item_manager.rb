class BulkListItemManager
  def initialize(shopping_list:, items_source:)
    @shopping_list = shopping_list
    @items_source = items_source
  end

  def add_items_to_list
    unassigned_aisle = Aisle.unassigned(@shopping_list)

    ingredients = @items_source.ingredients
    ingredients.each do |ingredient|
      item = @shopping_list.shopping_list_items.find_by(name: "#{ingredient.measurement_unit} #{ingredient.name}")

      if item.nil?
        ShoppingListItem.create!(
          shopping_list_id: @shopping_list.id,
          aisle_id: unassigned_aisle.id,
          quantity: ingredient.quantity,
          name: "#{ingredient.measurement_unit} #{ingredient.name}",
          purchased: false
        )
      else
        if item.purchased?
          item.update!(
            quantity: ingredient.quantity,
            purchased: false
          )
        else
          item.quantity += ingredient.quantity
          item.save
        end
      end
    end
  end

  def item_exists?(item)
    !item.nil?
  end
end
