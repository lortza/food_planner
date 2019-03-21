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
    # TIL .presence returns the receiver if it’s present otherwise returns nil
    recipe.image_url.presence || 'recipe_placeholder.jpg'
  end

  def status_flag(recipe)
    if !recipe.active?
      'archived'
    elsif recipe.last_prepared.nil?
      'new'
    elsif recipe.last_prepared < Date.today.prev_month(4)
      'been a while'
    else
    end
  end
end
