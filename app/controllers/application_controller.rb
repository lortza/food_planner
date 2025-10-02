# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_sentry_context

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  # New Configs: https://docs.sentry.io/platforms/ruby/migration/
  def set_sentry_context
    Sentry.set_user(id: session[:current_user_id]) # or anything else in session
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end
end
