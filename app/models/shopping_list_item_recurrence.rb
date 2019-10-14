# frozen_string_literal: true

class ShoppingListItemRecurrence
  FREQUENCIES = ['weekly', 'monthly']

  class << self
    def add_items_to_list(frequency)
      puts "Adding #{frequency} items to the list..."
      items = ShoppingListItem.where(recurrence_frequency: frequency)

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

    def run_weekly_task?
      Date.today.tuesday?
    end

    def run_monthly_task?
      Date.today == Date.today.end_of_month
    end
  end
end
