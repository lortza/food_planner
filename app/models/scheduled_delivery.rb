# frozen_string_literal: true

class ScheduledDelivery < ApplicationRecord
  belongs_to :shopping_list

  validates :scheduled_for,
            :service_provider,
            presence: true

end
