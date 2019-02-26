# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    recipe { association(:recipe) }
    sequence(:name) { |n| "ingredient name #{n}" }
    quantity { 1.5 }
    measurement_unit { Ingredient::UNITS[1..-1].sample }
    preparation_style { Ingredient::STYLES[1..-1].sample }
  end
end
