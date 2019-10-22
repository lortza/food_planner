# frozen_string_literal: true

FactoryBot.define do
  factory :experimental_recipe do
    user
    sequence(:title) { |n| "experimental_recipe#{n}" }
    sequence(:source_url) { |n| "http://www.google.com/#{n}" }
  end
end
