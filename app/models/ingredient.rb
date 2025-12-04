# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id                :bigint           not null, primary key
#  measurement_unit  :string           default(""), not null
#  name              :string           default(""), not null
#  preparation_style :string           default(""), not null
#  quantity          :float            default(0.0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  recipe_id         :bigint
#
# Indexes
#
#  index_ingredients_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (recipe_id => recipes.id)
#
class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  before_save :format_name

  STANDARD_UNITS = %w[
    4oz\ can
    6oz\ can
    7oz\ can
    15oz\ can
    30oz\ can
    as-needed
    box
    bulb
    bunch
    clove
    cup
    dash
    dozen
    handful
    head
    inch
    jar
    lb
    leaf
    loaf
    quart
    ounce
    pinch
    pint
    slice
    sprig
    stalk
    stem
    stick
    strip
    tablespoon
    teaspoon
    wedge
  ].freeze

  # Units that do not get pluralized
  DESCRIPTIVE_UNITS = %w[
    small
    medium
    large
    whole
  ].freeze

  UNITS = [
    STANDARD_UNITS,
    DESCRIPTIVE_UNITS
  ].flatten.sort

  STYLES = %w[
    \
    chopped
    cooked
    crumbled
    diced
    dried
    dry
    chopped
    crushed
    finely\ chopped
    grated
    ground
    julienned
    matchsticked
    minced
    piece
    raw
    ribboned
    shredded
    sliced
    sliced\ in\ half
    soaked\ overnight
    sorted
    thawed
    thinly\ sliced
    uncooked
  ].freeze

  validates :name,
    :quantity,
    :measurement_unit,
    presence: true

  validates :quantity, numericality: true
  validates :measurement_unit, inclusion: {in: UNITS}

  normalizes :name, with: ->(name) { name.strip.squish }

  def self.by_id
    order(:id)
  end

  def format_name
    self.name = name.downcase
  end

  def measurement_and_name
    "#{measurement_unit} #{name}"
  end
end
