# frozen_string_literal: true

# == Schema Information
#
# Table name: experimental_recipes
#
#  id         :bigint           not null, primary key
#  image_url  :string
#  source_url :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_experimental_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :experimental_recipe do
    user
    sequence(:title) { |n| "experimental_recipe#{n}" }
    sequence(:source_url) { |n| "http://www.example.com/#{n}" }

    trait :with_faker_data do
      title { Faker::Food.dish }
      image_url { "https://placehold.co/400x400" }
    end
  end
end
