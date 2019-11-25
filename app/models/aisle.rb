# frozen_string_literal: true

class Aisle < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy

  validates :name,
            :order_number,
            presence: true

  validates :name, uniqueness: { scope: :user_id }

  def self.unassigned(list)
    list.user.aisles
        .where('name ILIKE ?', 'unassigned')
        .first_or_create(name: 'unassigned')
  end

  def self.by_order_number
    order(order_number: :asc)
  end
end
