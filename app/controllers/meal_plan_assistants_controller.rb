# frozen_string_literal: true

# Chat page where Claude suggests recipes for the next meal prep. All data is
# scoped to current_user inside MealPlanAssistant, so no Pundit record applies.
class MealPlanAssistantsController < ApplicationController
  STARTERS = [
    "Surprise me",
    "Something cozy",
    "Quick and easy",
    "Things we haven't had in a while"
  ].freeze
  OVERDUE_RECIPE_COUNT = 3

  def show
    @prep_day = MealPlan.suggested_date(current_user)
    @overdue_recipes = current_user.recipes.active
      .where.not(last_prepared_on: nil)
      .by_last_prepared
      .limit(OVERDUE_RECIPE_COUNT)
    @starters = STARTERS
  end

  def create
    @user_message = (params[:starter].presence || params[:message]).to_s.strip

    begin
      @reply = MealPlanAssistant.reply(
        user: current_user,
        message: @user_message,
        history: parsed_history,
        tray_recipe_ids: tray_recipe_ids
      )
    rescue MealPlanAssistant::Error => e
      @error = e.message
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to meal_plan_assistant_path }
    end
  end

  private

  def parsed_history
    JSON.parse(params[:history].presence || "[]")
  rescue JSON::ParserError
    []
  end

  def tray_recipe_ids
    Array(params[:tray_recipe_ids]).map(&:to_i).uniq
  end
end
