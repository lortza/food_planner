# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
  has_many :items, class_name: 'ShoppingListItem'

  validates :name,
            presence: true

  def self.by_favorite
    order(favorite: :desc)
  end

  def favorite!
    self.favorite = true
    self.save!
  end

  def unfavorite!
    self.favorite = false
    self.save!
  end
end
