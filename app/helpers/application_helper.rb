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
    when 'warning' then 'warning'
    when 'notice' then 'success'
    else
      'info'
    end
  end

  def session_links
    if current_user
      link_to 'Sign Out',
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

  def display_link_to_plan(user)
    upcoming = MealPlan.upcoming(user)
    link_to "Meal Plan: #{upcoming.start_date.to_s(:short)}", meal_plan_path(upcoming), class: 'nav-link' if upcoming
  end

  def display_list_and_count(user)
    list = ShoppingList.default(user)
    item_count = list.shopping_list_items.not_purchased.count

    link_to "#{list.name.titleize}: #{item_count}", shopping_list_path(list), class: 'nav-link'
  end
end
