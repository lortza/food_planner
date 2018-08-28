# frozen_string_literal: true

module RecipesHelper
  def ingredient_display(ingredient)
    [
      qty_display(ingredient),
      ingredient.measurement_unit,
      ingredient.preparation_style,
      ingredient.name,
    ].join(' ')
  end

  def qty_display(ingredient)
    return ingredient.quantity.to_i if ingredient.quantity >= 1
    return ingredient.quantity.to_r if ingredient.quantity.positive?
  end

  def detail_display(detail)
    [
      qty_display(detail),
      detail.measurement_unit,
      detail.preparation_style,
      "(#{detail.recipe.title})",
    ].join(' ')
  end

  def display_minutes(time)
    return "#{time/60}h #{time%60}m" if time > 60
    return "#{time}m"
  end
end
