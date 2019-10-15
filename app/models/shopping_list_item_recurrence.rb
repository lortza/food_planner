# frozen_string_literal: true

class ShoppingListItemRecurrence
  FREQUENCIES = ['weekly', 'monthly']

  class << self
    def check_schedule
      puts 'Checking schedule...'
      today_is_weekly_item_day? ? add_items_to_list('weekly') : puts('No weekly items added. Today is not Tuesday.')
      today_is_monthly_item_day? ? add_items_to_list('monthly') : puts('No monthly items added. Today is not last of month.')
    end

    private

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

    def today_is_weekly_item_day?
      Date.today.tuesday?
    end

    def today_is_monthly_item_day?
      Date.today == Date.today.end_of_month
    end
  end
end
