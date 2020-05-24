# frozen_string_literal: true

class ScheduledDelivery < ApplicationRecord
  belongs_to :shopping_list

  validates :scheduled_for,
            :service_provider,
            presence: true

  def self.future
    hour_window = Time.zone.now - 3600
    where('scheduled_for >= ?', hour_window)
      .order(scheduled_for: :asc)
  end
end
