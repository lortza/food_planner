# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_flash_class(type)
    case type
    when 'alert' then 'warning'
    when 'error' then 'danger'
    when 'notice' then 'success'
    else
      'info'
    end
  end

  def session_links
    if current_user
      link_to "Sign Out #{current_user.email}", destroy_user_session_path, method: :delete, class: 'nav-link'
    else
      link_to 'Sign In', user_session_path, class: 'nav-link'
    end
  end

  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end

  def display_link_to_plan
    return link_to "Today's Plan: #{plan_for_today.start_date}", user_meal_plan_path(current_user, plan_for_today), class: 'dropdown-item' if plan_for_today
    return link_to "Coming up: #{plan_for_next_sunday.start_date}", user_meal_plan_path(current_user, plan_for_next_sunday), class: 'dropdown-item' if plan_for_next_sunday
  end

  private

  def plan_for_today
    MealPlan.find_by(start_date: Date.today)
  end

  def plan_for_next_sunday
    MealPlan.find_by(start_date: MealPlan.date_for_upcoming_sunday)
  end
end
