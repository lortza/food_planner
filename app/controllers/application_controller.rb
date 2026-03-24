# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_sentry_context

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def nav_bar_shopping_list
    return unless current_user&.shopping_lists&.default

    @nav_bar_shopping_list ||= current_user.shopping_lists.favorite || current_user.shopping_lists.default
  end

  helper_method :nav_bar_shopping_list

  def upcoming_meal_plan
    return unless current_user&.meal_plans&.upcoming

    @upcoming_meal_plan ||= current_user.meal_plans.upcoming
  end

  helper_method :upcoming_meal_plan

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  # New Configs: https://docs.sentry.io/platforms/ruby/migration/
  def set_sentry_context
    Sentry.set_user(id: current_user&.id)
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end
end
