# frozen_string_literal: true

module ScheduledDeliveriesHelper
  def display_scheduled_deliveries(deliveries)
    deliveries.map do |delivery|
      "#{delivery.service_provider} #{delivery.scheduled_for.to_s(:timestamp)}".squish
    end.join(' | ')
  end
end
