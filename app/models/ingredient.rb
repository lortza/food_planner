# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  before_save :format_name

  UNITS = %w[
    \
    bunch
    can
    clove
    cup
    dozen
    handful
    inch
    lb
    leaf
    loaf
    quart
    ounce
    pint
    slice
    sprig
    stalk
    T
    tsp
    whole
  ].freeze

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

  validates :measurement_unit, inclusion: { in: UNITS }
  # validates :preparation_style, inclusion: { in: STYLES },
                                # if: -> { preparation_style.present? }


  def self.by_id
    order(:id)
  end

  def whole_number?
    quantity % 1 == 0
  end

  def format_name
    self.name = name.downcase
  end
end
