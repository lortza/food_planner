# frozen_string_literal: true

module ApplicationHelper
  def display_time(minutes)
    TimeHelper.display_time(minutes)
  end
end
