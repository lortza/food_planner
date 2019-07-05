# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
end
