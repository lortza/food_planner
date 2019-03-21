# frozen_string_literal: true

module IngredientsHelper
  def ingredient_display(ingredient)
    [
      qty_display(ingredient),
      ingredient.measurement_unit,
      ingredient.name,
    ].join(' ')
  end

  def detail_display(detail)
    [
      qty_display(detail),
      detail.measurement_unit,
      detail.preparation_style,
      "(#{detail.recipe.title})",
    ].join(' ')
  end

  def qty_display(ingredient)
    return ingredient.quantity.to_i if ingredient.whole_number?

    fractions = {
      0.125 => '1/8',
      0.25 => '1/4',
      0.33 => '1/3',
      0.5 => '1/2',
      0.66 => '2/3',
      0.75 => '3/4'
    }
    if fractions[ingredient.quantity]
      fractions[ingredient.quantity]
    elsif ingredient.quantity >= 0.3 && ingredient.quantity <= 0.4
      fractions[0.33]
    elsif ingredient.quantity >= 0.6 && ingredient.quantity <= 0.7
      return fractions[0.66]
    else
      ingredient.quantity.round(3)
    end
  end
end
