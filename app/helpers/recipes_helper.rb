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

  def guaranteed_image(recipe)
    recipe.image_url.present? ? recipe.image_url : 'recipe_placeholder.jpg'
  end

  def status_flag(recipe)
    case
    when !recipe.active? then 'archived'
    when recipe.last_prepared == nil then 'new'
    when recipe.last_prepared < Date.today.prev_month(4) then 'been a while'
    end
  end
end
