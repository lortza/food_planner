# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :recipe, inverse_of: :ingredients
  before_save :format_name

  UNITS = %w[
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
    large
    lb
    leaf
    loaf
    medium
    quart
    ounce
    pint
    slice
    small
    sprig
    stalk
    stick
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

  # KNOWN_FOODS = %w[
  #   agave\ nectar
  #   apple\ cider\ vinegar
  #   coconut\ oil
  #   fresh\ ginger
  #   garlic
  #   green\ bell\ pepper
  #   green\ onions
  #   honey
  #   lime
  #   olive\ oil
  #   onion
  #   red\ bell\ pepper
  #   toasted\ sesame \oil
  # ].freeze

  validates :name,
            :quantity,
            :measurement_unit,
            presence: true

  validates :quantity, numericality: true
  validates :measurement_unit, inclusion: { in: UNITS }
  # validates :preparation_style, inclusion: { in: STYLES }, if: -> { preparation_style.present? }

  def self.by_id
    order(:id)
  end

  def format_name
    self.name = name.downcase
  end

  def measurement_and_name
    "#{measurement_unit} #{name}"
  end

  # def to_shopping_list_item
  #   ShoppingListItem.new(
  #     quantity: self.quantity,
  #     name: "#{self.measurement_unit} #{self.name}"
  #   )
  # end

  # def convert_to_food
  #   'WIP'
  # end

  # def self.parse(list)
  #   %Q(
  #     1/2 cup olive oil
  #     1 red bell pepper, seeded and chopped into big pieces
  #     2 tablespoons apple cider vinegar
  #     1 lime, juiced
  #     2 tablespoons agave nectar
  #     3/4 inch piece of fresh ginger, peeled and roughly chopped
  #     1 clove garlic
  #     totally optional: 1/4 teaspoon toasted sesame oil
  #   ).split("\n").map(&:strip)
  # end

  # def to_float
  # end
end
