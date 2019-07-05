# frozen_string_literal: true

class Aisle < ApplicationRecord
  belongs_to :user
  has_many :shopping_list_items, dependent: :destroy
end
