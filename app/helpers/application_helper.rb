# frozen_string_literal: true

module ApplicationHelper
  def page_title
    if content_for?(:title)
      content_for(:title)
    else
      'MyFoodPlanner'
    end
  end

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
      link_to "Sign Out #{current_user.email}",
              destroy_user_session_path,
              method: :delete,
              class: 'nav-link'
    else
      link_to 'Sign In',
              user_session_path,
              class: 'nav-link'
    end
  end

  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end

  def button_class(style = 'primary')
    "btn btn-sm btn-outline-#{style}"
  end

  def display_link_to_plan
    return link_to "Today's Plan: #{plan_for_today.start_date}", meal_plan_path(plan_for_today), class: 'nav-link' if plan_for_today # rubocop:disable Metrics/LineLength
    return link_to "Coming up: #{plan_for_next_sunday.start_date}", meal_plan_path(plan_for_next_sunday), class: 'nav-link' if plan_for_next_sunday # rubocop:disable Metrics/LineLength
  end

  private

  def plan_for_today
    MealPlan.find_by(start_date: Time.zone.today)
  end

  def plan_for_next_sunday
    MealPlan.find_by(start_date: MealPlan.date_for_upcoming_sunday)
  end
end
