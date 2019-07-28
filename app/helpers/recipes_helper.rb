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
end
