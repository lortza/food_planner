# frozen_string_literal: true

module RecipesHelper
  def show_recipe_form_fields?(recipe)
    # Unless recipe is a new pending record, show the form fields
    new_pending_recipe = recipe.pending? && recipe.id.nil?
    recipe.persisted? || !new_pending_recipe
  end

  def guaranteed_image(recipe)
    # TIL .presence returns the receiver if it's present otherwise returns nil
    recipe.image_url.presence || "recipe_placeholder.jpg"
  end

  def status_flag(recipe)
    if recipe.archived?
      icon = MaterialIcon.new(icon: :archived, size: :small).render
      content_tag(:span, "Archived",
        class: "badge badge-secondary ml-2 text-small font-weight-normal cursor-default",
        title: "Recipe is archived. Edit to unarchive.") { icon + " Archived" }
    elsif recipe.pending?
      icon = MaterialIcon.new(icon: :book, size: :small, title: "Pending").render
      content_tag(:span, "Pending",
        class: "badge badge-light ml-2 text-small font-weight-normal cursor-default",
        title: "Recipe has not been vetted or imported yet.") { icon + " Pending" }
    elsif recipe.last_prepared.nil? || first_time_is_this_week?(recipe)
      icon = MaterialIcon.new(icon: :new, size: :small, title: "New", classes: "cursor-default").render
      content_tag(:span, "New!",
        class: "badge badge-warning ml-2 text-small font-weight-normal cursor-default",
        title: "New! Has not been made yet!") { icon + " New!" }
      # MaterialIcon.new(icon: :new, classes: "text-warning cursor-default", title: "New! Has not been made yet").render
    elsif recipe.last_prepared < Time.zone.today.prev_month(4)
      MaterialIcon.new(icon: :calendar_clock, classes: "cursor-default", title: "It's been a while since this was last made").render
    else
      ""
    end
  end

  def extra_work_flag(recipe)
    return unless recipe.extra_work_required?

    MaterialIcon.new(icon: :clock, classes: "text-warning cursor-default", title: "Heads Up! #{recipe.extra_work_note}").render
  end

  def recipe_ingredient_ids(recipe)
    recipe.ingredients.pluck(:id)
  end

  def available_meal_plans_dropdown(user, recipe)
    user.meal_plans.future - recipe.meal_plans
  end

  private

  def first_time_is_this_week?(recipe)
    recipe.meal_plans.count == 1 &&
      recipe.meal_plans.first&.prepared_on == MealPlan.upcoming&.prepared_on
  end
end
