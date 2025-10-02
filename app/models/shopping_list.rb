# frozen_string_literal: true

# == Schema Information
#
# Table name: shopping_lists
#
#  id         :bigint           not null, primary key
#  favorite   :boolean          default(FALSE)
#  main       :boolean          default(FALSE)
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_shopping_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ShoppingList < ApplicationRecord
  extend Searchable

  DEFAULT_NAME = "grocery"

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
  has_many :items, class_name: "ShoppingListItem", dependent: :destroy
  has_many :scheduled_deliveries, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: {case_sensitive: false}

  normalizes :name, with: ->(name) { name.strip.squish }

  def self.default
    find_by(main: true)
  end

  def self.by_favorite
    order(favorite: :desc)
  end

  def default?
    main == true
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
      shopping_list_items.search(field: "name", terms: terms).by_name
    else
      shopping_list_items.by_name
    end
  end
end
