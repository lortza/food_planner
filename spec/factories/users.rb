# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@email.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
