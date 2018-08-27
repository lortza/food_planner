# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    recipe nil
    quantity 1.5
    measurement 'MyString'
    name 'MyString'
    preparation_style 'MyString'
  end
end
