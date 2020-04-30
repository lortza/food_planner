# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  extend Searchable

  STATUSES = %w[active inactive in_cart]

  belongs_to :aisle
  belongs_to :shopping_list
  belongs_to :list, foreign_key: :shopping_list_id, class_name: 'ShoppingList' # rubocop:disable Rails/InverseOf

  validates :name,
            :quantity,
            :aisle_id,
            :shopping_list_id,
            presence: true

  validates :status,
            presence: true,
            inclusion: { in: STATUSES }

  # validates :recurrence_frequency, inclusion: { in: ShoppingListItemRecurrence::FREQUENCIES }

  scope :active, -> { where(status: 'active') }
  scope :not_purchased, -> { where(status: 'active').or(ShoppingListItem.where(status: 'in_cart')) }
  scope :inactive, -> { where(status: 'inactive') }

  def self.by_recently_edited
    order(updated_at: 'DESC')
  end

  def self.by_aisle_order_number
    includes(:aisle).order('aisles.order_number')
  end

  def active?
    status == 'active'
  end

  def inactive?
    status == 'inactive'
  end

  def in_cart?
    status == 'in_cart'
  end

  def deactivate!
    update!(status: 'inactive')
  end

  def activate!
    update!(status: 'active')
  end

  def add_to_cart!
    update!(status: 'in_cart')
  end
end
