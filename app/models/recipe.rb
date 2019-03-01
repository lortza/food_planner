# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank,  # Option: validates that at least 1 ingredient should be present
                                allow_destroy: true # Option: allows a user to delete an ingredient via a checkbox on the edit form (see below)
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes

  DEFAULT_SOURCE = { source_name: 'Original Creation', source_url: '/' }.freeze
  DEFAULT_PARAMS = {
    prep_time: 10,
    cook_time: 20,
    servings: 2
  }.freeze

  before_validation :provide_default_source, on: :create
  # before_save :instructions_to_lines

  validates :title,
            :servings,
            :instructions,
            :source_name,
            :source_url,
            :prep_time,
            :cook_time,
            :reheat_time,
            presence: true

  validates :prep_time, numericality: { other_than: 0 }, if: -> {cook_time == 0 && reheat_time == 0}
  validates :cook_time, numericality: { other_than: 0 }, if: -> {reheat_time == 0 && prep_time == 0}
  validates :reheat_time, numericality: { other_than: 0 }, if: -> {prep_time == 0 && cook_time == 0}

  def self.search(terms)
    if terms.blank?
      all
    else
      where("title ILIKE ?", "%#{terms}%")
    end
  end

  def self.by_title
    order(:title)
    # all.includes(:meal_plans).order('meal_plans.start_date, DESC')
  end

  def self.for_prep_date(date)
    # WIP
    # Recipe.joins(:preparations).where(preparations: {date: date})
  end

  def self.active
    where(archived: false)
  end

  def active?
    archived == false
  end

  def frequency
    meal_plans.count
  end

  def provide_default_source
    self.source_name = DEFAULT_SOURCE[:source_name] if source_name.blank?
    self.source_url = DEFAULT_SOURCE[:source_url] if source_url.blank?
  end

  def title_and_date
    last_prepared ? title + ": #{last_prepared}" : title
  end

  def last_prepared
    meal_plans.pluck(:start_date).max
  end

  def total_time
    prep_time + cook_time
  end

  def instructions_to_lines
    self.instructions = instructions.gsub(/\r/, "\n")
  end
end
