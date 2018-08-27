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

  STYLE = %w[
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
end
