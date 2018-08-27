# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe

  UNITS = %w[
    cup
    handful
    quart
    ounce
    T
    tsp
  ].freeze

  STYLES = %w[
    chopped
    cooked
    diced
    dry
    crushed
    ground
    julienned
    minced
    raw
    ribboned
    sliced
    soaked\ overnight
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
