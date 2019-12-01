# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  extend Searchable
  
  belongs_to :aisle
  belongs_to :shopping_list
  belongs_to :list, foreign_key: :shopping_list_id, class_name: 'ShoppingList' # rubocop:disable Rails/InverseOf

  validates :name,
            :quantity,
            :aisle_id,
            :shopping_list_id,
            presence: true

  # validates :recurrence_frequency, inclusion: { in: ShoppingListItemRecurrence::FREQUENCIES }

  scope :not_purchased, -> { where(purchased: false) }
  scope :purchased, -> { where(purchased: true) }

  def self.by_recently_edited
    order(updated_at: 'DESC')
  end

  def self.by_aisle_order_number
    includes(:aisle).order('aisles.order_number')
  end

  # Set the item's purchased setting to true and save the item
  def complete!
    update!(purchased: true)
  end

  # Set the item's purchased setting to false and save the item
  def uncomplete!
    update!(purchased: false)
  end
end
