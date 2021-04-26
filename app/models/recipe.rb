# frozen_string_literal: true

class Recipe < ApplicationRecord
  extend Searchable

  attr_accessor :experimental_recipe_id
  attr_accessor :remove_attached_image

  belongs_to :user
  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  accepts_nested_attributes_for :ingredients,
                                reject_if: :all_blank, # at least 1 ingredient should be present
                                allow_destroy: true # allows user to delete ingredient via checkbox
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes
  has_one_attached :image

  DEFAULT_SOURCE = { source_name: 'Original Creation', source_url: '/' }.freeze
  DEFAULT_PARAMS = {
    prep_time: 10,
    cook_time: 20,
    servings: 2
  }.freeze

  before_validation :provide_default_source, on: :create
  # before_save :instructions_to_lines

  validate :acceptable_image
  validates :title,
            :servings,
            :instructions,
            :source_name,
            :source_url,
            :prep_time,
            :cook_time,
            :reheat_time,
            presence: true

  validates :prep_time, numericality: { other_than: 0 }, if: -> { cook_time&.zero? && reheat_time&.zero? }
  validates :cook_time, numericality: { other_than: 0 }, if: -> { reheat_time&.zero? && prep_time&.zero? }
  validates :reheat_time, numericality: { other_than: 0 }, if: -> { prep_time&.zero? && cook_time&.zero? }

  after_save :purge_attached_image, if: :remove_attached_image?

  def self.for_prep_date(date)
    # WIP
    # Recipe.joins(:preparations).where(preparations: {date: date})
  end

  def self.by_last_prepared
    order('meal_plans.prepared_on asc')
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

  def checkbox_label
    output = "#{title} (#{servings} servings)"
    last_prepared ? output + ": #{last_prepared}" : output
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

  private

  def acceptable_image
    return unless image.attached?

    if image.byte_size > 1.megabyte
      image_size = (image.byte_size / 1_000_000.0).round(2)
      errors.add(:image, "size #{image_size} MB exceeds 1 MB limit")
    end

    acceptable_types = ['image/jpeg', 'image/jpg', 'image/png']
    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end

  def remove_attached_image?
    remove_attached_image == '1'
  end

  def purge_attached_image
    image.purge_later
  end
end
