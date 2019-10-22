# frozen_string_literal: true

class ExperimentalRecipe < ApplicationRecord
  belongs_to :user

  validates :title,
            :source_url,
            presence: true
end
