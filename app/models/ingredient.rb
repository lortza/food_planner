# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe
  before_save :format_name

  UNITS = %w[
    can
    cup
    handful
    leaf
    quart
    ounce
    slice
    sprig
    stalk
    T
    tsp
    whole
  ].freeze

  STYLES = %w[
    chopped
    cooked
    crumbled
    diced
    dry
    chopped
    crushed
    finely\ chopped
    grated
    ground
    julienned
    matchsticked
    minced
    raw
    ribboned
    sliced
    soaked\ overnight
    sorted
    thinly\ sliced
    uncooked
  ].freeze

  validates :recipe_id,
            :name,
            :quantity,
            :measurement_unit,
            :preparation_style,
            presence: true

  validates :measurement_unit, inclusion: { in: UNITS }
  validates :preparation_style, inclusion: { in: STYLES }
  def format_name
    self.name = name.downcase
  end
end
