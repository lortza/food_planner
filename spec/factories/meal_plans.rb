# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    user
    prepared_on { rand((Time.zone.today - 10)...Time.zone.today) }
    people_served { 2 }
    notes { '' }
  end
end
