# frozen_string_literal: true

# == Schema Information
#
# Table name: aisles
#
#  id           :bigint           not null, primary key
#  name         :string
#  order_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_aisles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :aisle do
    user_id { create(:user).id }
    sequence(:name) { |n| "aisle name #{n}" }
    sequence(:order_number) { |n| n }
  end
end
