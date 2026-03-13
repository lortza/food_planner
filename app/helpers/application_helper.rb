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
      link_to "Sign Out", destroy_user_session_path, method: :delete, class: "nav-link"
    else
      link_to "Sign In", user_session_path, class: "nav-link"
    end
  end

  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end

  def update_nav_bar_shopping_list_count?(shopping_list)
    nav_bar_shopping_list && shopping_list.id == nav_bar_shopping_list.id
  end
end
