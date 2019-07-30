# frozen_string_literal: true

FactoryBot.define do
  factory :shopping_list do
    user
    sequence(:name) { |n| "Shopping List Name #{n}" }
  end
end
