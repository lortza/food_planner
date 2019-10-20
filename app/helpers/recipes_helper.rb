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
end
