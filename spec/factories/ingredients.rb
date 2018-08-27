# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    recipe { association(:recipe) }
    sequence(:name) { |n| "ingredient name #{n}" }
    quantity { 1.5 }
    measurement_unit { Ingredient::UNITS.sample }
    preparation_style { Ingredient::STYLES.sample }
  end
end
