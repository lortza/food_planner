# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan do
    start_date { rand((Time.zone.today - 10)...Time.zone.today) }
    people_served { 2 }
  end
end
