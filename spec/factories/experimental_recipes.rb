# frozen_string_literal: true

# == Schema Information
#
# Table name: experimental_recipes
#
#  id         :bigint           not null, primary key
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
    sequence(:source_url) { |n| "http://www.google.com/#{n}" }
  end
end
