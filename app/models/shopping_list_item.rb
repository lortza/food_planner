# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :aisle
  belongs_to :shopping_list
  belongs_to :list, foreign_key: :shopping_list_id, class_name: 'ShoppingList'

  validates :name,
            :quantity,
            :aisle_id,
            :shopping_list_id,
            presence: true

  scope :not_purchased, -> { where(purchased: false) }
  scope :purchased, -> { where(purchased: true) }

  def self.by_recently_edited
    order(updated_at: 'DESC')
  end
end
