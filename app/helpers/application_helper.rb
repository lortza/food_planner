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
      link_to 'Sign Out', destroy_user_session_path, method: :delete, class: 'nav-link'
    else
      link_to 'Sign In', user_session_path, class: 'nav-link'
    end
  end

  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end

  def display_link_to_plan
    if plan_for_next_sunday
      link_to "Coming up: #{plan_for_next_sunday.start_date}", plan_for_next_sunday, class: 'dropdown-item'
    end
  end

  def plan_for_next_sunday
    MealPlan.find_by(start_date: MealPlan.date_for_upcoming_sunday)
  end
end
