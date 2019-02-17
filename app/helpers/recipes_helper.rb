# frozen_string_literal: true

module RecipesHelper
  def ingredient_display(ingredient)
    [
      qty_display(ingredient),
      ingredient.measurement_unit,
      ingredient.name,
    ].join(' ')
  end

  def qty_display(ingredient)
    return ingredient.quantity.to_i if ingredient.whole_number?
    ingredient.quantity.round(3)
  end

  def detail_display(detail)
    [
      qty_display(detail),
      detail.measurement_unit,
      detail.preparation_style,
      "(#{detail.recipe.title})",
    ].join(' ')
  end
end
