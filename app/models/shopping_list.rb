# frozen_string_literal: true

class ShoppingList < ApplicationRecord
  extend Searchable
  DEFAULT_NAME = 'grocery'

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
  has_many :items, class_name: 'ShoppingListItem', dependent: :destroy

  validates :name,
            presence: true

  def self.default
    where(main: true).first
  end

  def self.by_favorite
    order(favorite: :desc)
  end

  def deletable?
    main == false
  end

  def favorite!
    update!(favorite: true)
  end

  def unfavorite!
    update!(favorite: false)
  end

  def search_results(terms)
    if terms
      shopping_list_items.search(field: 'name', terms: terms).by_name
    else
      shopping_list_items.by_name
    end
  end
end
