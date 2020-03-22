# frozen_string_literal: true

module IngredientsHelper
  def ingredient_display(ingredient)
    display_name = [
      qty_display(ingredient),
      ingredient.measurement_unit,
      ingredient.name,
    ].join(' ')

    if ingredient.preparation_style.present?
      "#{display_name}: #{ingredient.preparation_style}"
    else
      display_name
    end
  end

  def detail_display(detail)
    ingredient = [
      qty_display(detail),
      detail.measurement_unit,
      detail.preparation_style,
      "(#{detail.recipe.title})",
    ].join(' ')

    link_to ingredient, recipe_path(detail.recipe)
  end

  def qty_display(ingredient)
    return ingredient.quantity.to_i if NumbersHelper.whole_number?(ingredient.quantity)

    process_fraction(ingredient.quantity)
  end

  private

  def process_fraction(number)
    if known_fraction(number)
      known_fraction(number)
    elsif number >= 0.3 && number <= 0.4
      known_fraction(0.33)
    elsif number >= 0.6 && number <= 0.7
      known_fraction(0.66)
    else
      number.round(3)
    end
  end

  def known_fraction(number)
    fractions = {
      0.125 => '1/8',
      0.25 => '1/4',
      0.33 => '1/3',
      0.5 => '1/2',
      0.66 => '2/3',
      0.75 => '3/4'
    }
    fractions[number]
  end
end
