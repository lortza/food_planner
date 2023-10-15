# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  extend Searchable

  STATUSES = %w[active inactive in_cart].freeze

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
  scope :inactive, -> { where(status: 'inactive') }
  # DEPRECATION WARNING: Class level methods will no longer inherit scoping from `not_purchased`
  # in Rails 6.1. To continue using the scoped relation, pass it into the blockdirectly. To instead
  # access the full set of models, as Rails 6.1 will, use `ShoppingListItem.default_scoped`. (called
  # from block in <class:ShoppingListItem> at app/models/shopping_list_item.rb:25)
  scope :not_purchased, -> { where(status: 'active').or(ShoppingListItem.where(status: 'in_cart')) }

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

  # TODO: toggle icon in place instead of using html in js
  # def remove_from_cart!
  #   update!(status: 'active')
  # end
end
