# frozen_string_literal: true

FactoryBot.define do
  factory :meal_plan_recipe do
    meal_plan
    recipe
  end
end
