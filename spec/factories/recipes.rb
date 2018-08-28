# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Recipe Title #{n}" }
    sequence(:source_name) { |n| "Recipe Source #{n}" }
    sequence(:source_url) { |n| "http://recipesource#{n}.com" }
    prep_time { rand(10..20) }
    cook_time { rand(10..60) }
    servings { rand(10) }
    instructions {
      [
        'Lorem ipsum dolor sit amet.',
        'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.',
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
        'Nisi ut aliquip ex ea commodo consequat.',
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum.',
        'Excepteur sint occaecat cupidatat non proident.',
        'Sunt in culpa qui officia deserunt mollit anim id est laborum.',
      ].join("\n\n")
    }
  end
end
