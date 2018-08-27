# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title 'MyString'
    source_name 'MyString'
    source_url 'MyString'
    servings 1
    instructions 'MyText'
  end
end
