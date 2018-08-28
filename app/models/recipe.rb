# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  before_validation :provide_default_source, on: :create

  validates :title,
            :servings,
            :instructions,
            :source_name,
            :source_url,
            presence: true

  def provide_default_source
    self.source_name = 'Original Creation' if source_name.blank?
    self.source_url = '/' if source_url.blank?
  end
end
