# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  validates :title,
            :servings,
            :instructions,
            :source_name,
            :source_url,
            presence: true
end
