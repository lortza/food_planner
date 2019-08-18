# frozen_string_literal: true

class Aisle < ApplicationRecord
  extend Searchable

  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id }

  def self.unassigned(list)
    user = User.find(list.user_id)
    aisle = user.aisles.where('name ILIKE ?', 'unassigned').first

    if aisle.nil?
      aisle = create!(name: 'unassigned', user_id: user.id)
    end
    aisle
  end
end
