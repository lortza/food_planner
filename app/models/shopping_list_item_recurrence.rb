# frozen_string_literal: true

class ShoppingListItemRecurrence
  FREQUENCIES = %w[weekly biweekly monthly].freeze

  class << self
    def check_schedule
      Rails.logger.info('Checking schedule...')
      add_weekly_item? ? add_items_to_list('weekly') : Rails.logger.info('No weekly items added.')
      add_biweekly_item? ? add_items_to_list('biweekly') : Rails.logger.info('No biweekly items added.')
      add_monthly_item? ? add_items_to_list('monthly') : Rails.logger.info('No monthly items added.')
    end

    private

    def add_items_to_list(frequency)
      Rails.logger.info("Adding #{frequency} items to the list.")
      items = ShoppingListItem.where(recurrence_frequency: frequency)

      items.each do |item|
        Rails.logger.info(item.name)
        if item.purchased == true
          item.purchased = false
          item.quantity = item.recurrence_quantity
        else
          item.quantity += item.recurrence_quantity
        end
        item.save
      end
    end

    def add_weekly_item?
      today_is_weekly_item_day?
    end

    def add_biweekly_item?
      today_is_weekly_item_day? && today_is_biweekly_week?
    end

    def add_monthly_item?
      today_is_weekly_item_day? && today_is_last_week_of_month?
    end

    def today_is_weekly_item_day?
      Time.zone.today.tuesday?
    end

    def today_is_biweekly_week?
      today = Date.current.day
      second_week = (8..14).to_a
      fourth_week = (22..31).to_a

      (second_week + fourth_week).include?(today)
    end

    def today_is_last_week_of_month?
      the_month_this_week = Date.current.month
      the_month_next_week = 1.week.from_now.month

      the_month_this_week != the_month_next_week
    end
  end
end
