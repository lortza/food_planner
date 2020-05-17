# frozen_string_literal: true

class ExperimentalRecipe < ApplicationRecord
  extend Searchable

  belongs_to :user

  validates :title,
            :source_url,
            presence: true
end
