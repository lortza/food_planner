# frozen_string_literal: true

class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :meal_plan_recipes, dependent: :nullify
  has_many :meal_plans, through: :meal_plan_recipes

  DEFAULT_PARAMS = { prep_time: 10, cook_time: 20 }.freeze

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

  def last_prepared
    meal_plans.pluck(:start_date).max
  end

  def total_time
    prep_time + cook_time
  end
end
