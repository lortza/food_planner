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
end
