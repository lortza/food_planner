# frozen_string_literal: true

# == Schema Information
#
# Table name: recipes
#
#  id                    :bigint           not null, primary key
#  cook_time             :integer          default(0), not null
#  extra_work_note       :string
#  image_url             :string           default(""), not null
#  instructions          :text             default(""), not null
#  last_prepared_on      :date
#  notes                 :text
#  nutrition_data_iframe :text
#  pepperplate_url       :string
#  prep_day_instructions :text             default("")
#  prep_time             :integer          default(0), not null
#  reheat_instructions   :text             default("")
#  reheat_time           :integer          default(0)
#  servings              :integer          default(0), not null
#  source_name           :string           default(""), not null
#  source_url            :string           default(""), not null
#  status                :integer          default("active"), not null
#  title                 :string           default(""), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :bigint
#
# Indexes
#
#  index_recipes_on_status   (status)
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recipe < ApplicationRecord
  extend Searchable

  enum :status, {pending: 0, active: 1, archived: 2}

  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
    reject_if: :all_blank, # at least 1 ingredient should be present
    allow_destroy: true # allows user to delete ingredient via checkbox
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes

  DEFAULT_SOURCE = {source_name: "Original Creation", source_url: "/"}.freeze
  DEFAULT_PARAMS = {
    prep_time: 10,
    cook_time: 20,
    servings: 2
  }.freeze

  before_validation :provide_default_source, on: :create
  # before_save :instructions_to_lines

  validates :title, :source_url, presence: true
  validates :title, uniqueness: {scope: :user_id, case_sensitive: false}

  # These validations are skipped if the recipe is pending, but run for all other statuses
  with_options unless: :pending? do
    before_validation :guarantee_instructions_values, on: :create

    validates :servings,
      :instructions,
      :prep_day_instructions,
      :source_name,
      :prep_time,
      :cook_time,
      :reheat_time,
      presence: true

    validates :prep_time, numericality: {other_than: 0}, if: -> { cook_time&.zero? && reheat_time&.zero? }
    validates :cook_time, numericality: {other_than: 0}, if: -> { reheat_time&.zero? && prep_time&.zero? }
    validates :reheat_time, numericality: {other_than: 0}, if: -> { prep_time&.zero? && cook_time&.zero? }
  end

  normalizes :title, with: ->(title) { title.strip.squish }

  scope :active_or_pending, -> { where(status: [:pending, :active]) }

  def self.for_prep_date(date)
    # WIP
    # Recipe.joins(:preparations).where(preparations: {date: date})
  end

  def self.by_last_prepared
    order("meal_plans.prepared_on asc")
  end

  def frequency
    meal_plans.count
  end

  def provide_default_source
    self.source_name = DEFAULT_SOURCE[:source_name] if source_name.blank?
    self.source_url = DEFAULT_SOURCE[:source_url] if source_url.blank?
  end

  def guarantee_instructions_values
    return false if prep_day_instructions.blank? && instructions.blank?

    self.instructions = prep_day_instructions if instructions.blank?
    self.prep_day_instructions = instructions if prep_day_instructions.blank?
  end

  def last_prepared
    meal_plans.pluck(:prepared_on).max
  end

  def total_time
    prep_time + cook_time
  end

  def instructions_to_lines
    self.instructions = instructions.tr("\r", "\n")
  end

  def extra_work_required?
    extra_work_note.present?
  end

  def dupe_for_user(user)
    original_ingredients = ingredients
    copied_recipe = dup
    copied_recipe.update(user_id: user.id)
    original_ingredients.each do |ingredient|
      copied_ingredient = ingredient.dup
      copied_recipe.ingredients << copied_ingredient
    end
  end
end
