# frozen_string_literal: true

module RecipesHelper
  def guaranteed_image(recipe)
    # TIL .presence returns the receiver if it's present otherwise returns nil
    recipe.image_url.presence || 'recipe_placeholder.jpg'
  end

  def status_flag(recipe)
    if !recipe.active?
      'archived'
    elsif recipe.last_prepared.nil?
      'new'
    elsif recipe.last_prepared < Time.zone.today.prev_month(4)
      'been a while'
    else
      ''
    end
  end

  def extra_work_flag(recipe)
    return unless recipe.extra_work_required?

    "<i class=\"#{Icon.clock}\", title=\"Heads Up! #{recipe.extra_work_note}\"></i>".html_safe
  end

  def recipe_ingredient_ids(recipe)
    recipe.ingredients.pluck(:id)
  end

  def available_meal_plans_dropdown(user, recipe)
    user.meal_plans.future - recipe.meal_plans
  end
end
