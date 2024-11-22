# frozen_string_literal: true

module ApplicationHelper
  def page_title
    if content_for?(:title)
      content_for(:title)
    else
      "MyFoodPlanner"
    end
  end

  def session_links
    if current_user
      link_to "Sign Out",
        destroy_user_session_path,
        method: :delete,
        class: "nav-link"
    else
      link_to "Sign In",
        user_session_path,
        class: "nav-link"
    end
  end

  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end

  def display_link_to_plan
    upcoming = current_user.meal_plans.upcoming
    link_to "Meal Plan: #{upcoming.prepared_on.to_fs(:short)}", meal_plan_path(upcoming), class: "nav-link" if upcoming
  end

  def display_list_and_count
    return "" unless current_user.shopping_lists.any?

    list = current_user.shopping_lists.default
    item_count = list.shopping_list_items.active.count

    link_to "#{list.name.titleize}: #{item_count}", shopping_list_path(list), class: "nav-link"
  end
end
