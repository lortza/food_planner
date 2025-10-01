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
class Aisle < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy

  validates :name,
    :order_number,
    presence: true

  validates :name, uniqueness: {scope: :user_id}

  normalizes :name, with: ->(name) { name.strip.squish }

  def self.unassigned(list)
    list.user.aisles
      .where("name ILIKE ?", "unassigned")
      .first_or_create(name: "unassigned", order_number: 0)
  end

  def self.by_order_number
    order(order_number: :asc)
  end
end
