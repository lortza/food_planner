# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_list_items
#
#  id                   :bigint           not null, primary key
#  heb_upc              :string
#  name                 :string
#  quantity             :float
#  recurrence_frequency :string
#  recurrence_quantity  :float            default(0.0)
#  status               :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  aisle_id             :bigint
#  shopping_list_id     :bigint
#
# Indexes
#
#  index_shopping_list_items_on_aisle_id          (aisle_id)
#  index_shopping_list_items_on_shopping_list_id  (shopping_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (aisle_id => aisles.id)
#  fk_rails_...  (shopping_list_id => shopping_lists.id)
#
class ShoppingListItem < ApplicationRecord
  extend Searchable

  STATUSES = %w[active inactive in_cart].freeze

  belongs_to :aisle
  belongs_to :shopping_list
  belongs_to :list, foreign_key: :shopping_list_id, class_name: "ShoppingList" # rubocop:disable Rails/InverseOf

  validates :name,
    :quantity,
    :aisle_id,
    :shopping_list_id,
    presence: true

  validates :status,
    presence: true,
    inclusion: {in: STATUSES}

  # validates :recurrence_frequency, inclusion: { in: ShoppingListItemRecurrence::FREQUENCIES }

  scope :active, -> { where(status: "active") }
  scope :inactive, -> { where(status: "inactive") }
  scope :not_purchased, -> { where(status: "active").or(where(status: "in_cart")) }

  def self.by_recently_edited
    order(updated_at: "DESC")
  end

  def self.by_aisle_order_number
    includes(:aisle).order("aisles.order_number ASC, shopping_list_items.name ASC")
  end

  def active?
    status == "active"
  end

  def inactive?
    status == "inactive"
  end

  def in_cart?
    status == "in_cart"
  end

  def deactivate!
    update!(status: "inactive")
  end

  def activate!
    update!(status: "active")
  end

  def add_to_cart!
    update!(status: "in_cart")
  end

  def remove_from_cart!
    update!(status: "active")
  end
end
