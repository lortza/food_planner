# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe

  UNITS = %w[
    can
    cup
    handful
    leaf
    quart
    ounce
    slice
    sprig
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
end
