# frozen_string_literal: true

module IngredientsHelper
  def ingredient_display(ingredient:, multiplier: 1)
    quantity = ingredient.quantity * multiplier
    display_name = if Ingredient::DESCRIPTIVE_UNITS.include?(ingredient.measurement_unit)
      pluralize(qty_display(quantity), "#{ingredient.measurement_unit} #{ingredient.name}")
    else
      "#{pluralize(qty_display(quantity), ingredient.measurement_unit)} #{ingredient.name}"
    end

    return "#{display_name}: #{ingredient.preparation_style}" if ingredient.preparation_style.present?

    display_name
  end

  def detail_display(detail)
    pluralized = if Ingredient::DESCRIPTIVE_UNITS.include?(detail.measurement_unit)
      "#{qty_display(detail.quantity)} #{detail.measurement_unit}"
    else
      pluralize(qty_display(detail.quantity), detail.measurement_unit)
    end

    [
      pluralized,
      detail.preparation_style.presence
    ].compact.join(" ")
  end

  def qty_display(quantity)
    return quantity.to_i if NumbersHelper.whole_number?(quantity)

    process_fraction(quantity)
  end

  private

  def process_fraction(number)
    # Use an exact known fraction (e.g. 0.5), otherwise round the value down to
    # two decimal places and try again (e.g. 0.6666 -> 0.66 -> "2/3"). Anything
    # that still has no known fraction falls back to a rounded decimal.
    known_fraction(number) || known_fraction(number.floor(2)) || number.round(3)
  end

  def known_fraction(number)
    fractions = {
      0.0625 => "1/16",
      0.125 => "1/8",
      0.25 => "1/4",
      0.33 => "1/3",
      0.375 => "3/8",
      0.5 => "1/2",
      0.625 => "5/8",
      0.66 => "2/3",
      0.75 => "3/4",
      0.875 => "7/8"
    }
    fractions[number]
  end
end
