# frozen_string_literal: true

class ShoppingListItem < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :aisle
  validates :name,
            :quantity,
            :aisle_id,
            :shopping_list_id,
            presence: true
end
