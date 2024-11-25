# frozen_string_literal: true

module ScheduledDeliveriesHelper
  def display_scheduled_deliveries(deliveries)
    deliveries.map do |delivery|
      link_to "#{delivery.service_provider} #{delivery.scheduled_for.to_fs(:timestamp)}".squish,
        edit_shopping_list_scheduled_delivery_path(delivery.shopping_list, delivery)
    end.join(" | ").html_safe
  end
end
