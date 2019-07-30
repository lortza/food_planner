# frozen_string_literal: true

FactoryBot.define do
  factory :aisle do
    user
    sequence(:name) { |n| "ingredient name #{n}" }
    sequence(:number) { |n| n }
  end
end
