# frozen_string_literal: true

class ShoppingListItemRecurrence
  FREQUENCIES = ['weekly', 'monthly']

  def self.add_items_to_list(items)
    items.each do |item|
      puts item.name
      if item.purchased == true
        item.purchased = false
        item.quantity = item.recurrence_quantity
        item.save
      else
        item.quantity += item.recurrence_quantity
        item.save
      end
    end
  end
end
