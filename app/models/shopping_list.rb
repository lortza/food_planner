# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
  has_many :items, class_name: 'ShoppingListItem', dependent: :destroy

  validates :name,
            presence: true

  def self.default(user)
    default_name = 'grocery'
    list = user.shopping_lists.where('name ILIKE ?', default_name).first

    if list.nil?
      list = create!(name: default_name, user_id: user.id)
    end

    list
  end

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
