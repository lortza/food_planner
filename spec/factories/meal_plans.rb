# frozen_string_literal: true

# == Schema Information
#
# Table name: meal_plans
#
#  id            :bigint           not null, primary key
#  notes         :text
#  people_served :integer          default(0), not null
#  prepared_on   :date             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_meal_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :meal_plan do
    user
    prepared_on { rand((Time.zone.today - 10)...Time.zone.today) }
    people_served { 2 }
    notes { "" }
  end
end
