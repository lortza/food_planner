# frozen_string_literal: true

# == Schema Information
#
# Table name: scheduled_deliveries
#
#  id               :bigint           not null, primary key
#  scheduled_for    :datetime
#  service_provider :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shopping_list_id :bigint           not null
#
# Indexes
#
#  index_scheduled_deliveries_on_shopping_list_id  (shopping_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (shopping_list_id => shopping_lists.id)
#
FactoryBot.define do
  factory :scheduled_delivery do
    shopping_list
    scheduled_for { Time.zone.now.to_s }
    sequence(:service_provider) { |n| "ServiceProvider#{n}" }
  end
end
