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
class ScheduledDelivery < ApplicationRecord
  belongs_to :shopping_list

  validates :scheduled_for, :service_provider, presence: true

  scope :future, -> { where(scheduled_for: Time.zone.now..).order(scheduled_for: :asc) }
  scope :today_and_beyond, -> { where(scheduled_for: Date.today.beginning_of_day..).order(scheduled_for: :asc) }
end
