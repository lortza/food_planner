# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Recipe Title #{n}" }
    sequence(:source_name) { |n| "Recipe Source #{n}" }
    sequence(:source_url) { |n| "http://recipesource#{n}.com" }
    servings { rand(10) }
    instructions { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.' }
  end
end
