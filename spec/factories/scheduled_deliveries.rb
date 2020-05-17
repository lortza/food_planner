# frozen_string_literal: true

FactoryBot.define do
  factory :scheduled_delivery do
    shopping_list
    scheduled_for { Time.zone.now.to_s }
    sequence(:service_provider) { |n| "ServiceProvider#{n}" }
  end
end
