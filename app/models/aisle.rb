# frozen_string_literal: true

class Aisle < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id }

end
