# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  before_save :format_name

  STANDARD_UNITS = %w[
    4oz\ can
    7oz\ can
    15oz\ can
    30oz\ can
    box
    bulb
    bunch
    clove
    cup
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
    pint
    slice
    sprig
    stalk
    stick
    tablespoon
    teaspoon
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
    DESCRIPTIVE_UNITS,
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
  validates :measurement_unit, inclusion: { in: UNITS }

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
