# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_tag do
    recipe
    tag
  end
end
