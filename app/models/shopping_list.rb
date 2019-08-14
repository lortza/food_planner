# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
  has_many :items, class_name: 'ShoppingListItem', dependent: :destroy

  validates :name,
            presence: true

  def self.by_favorite
    order(favorite: :desc)
  end

  def favorite!
    update!(favorite: true)
  end

  def unfavorite!
    update!(favorite: false)
  end
end
