# frozen_string_literal: true

# Chat page where Claude suggests recipes for the next meal prep. All data is
# scoped to current_user, so no Pundit record applies.
class MealPlanAssistantsController < ApplicationController
  STARTERS = [
    "Surprise me",
    "Something cozy",
    "Quick and easy",
    "Things we haven't had in a while"
  ].freeze
  OVERDUE_RECIPE_COUNT = 3

  before_action :set_prep_day_and_conversation

  def show
    @meal_plan = MealPlanAssistant.meal_plan_for(current_user, prep_day: @prep_day)
    @turns = @conversation.turns
    @overdue_recipes = current_user.recipes.active
      .where.not(last_prepared_on: nil)
      .by_last_prepared
      .limit(OVERDUE_RECIPE_COUNT)
    @starters = STARTERS
  end

  def create
    @user_message = (params[:starter].presence || params[:message]).to_s.strip
    meal_plan = MealPlanAssistant.meal_plan_for(current_user, prep_day: @prep_day)

    begin
      reply = MealPlanAssistant.reply(
        user: current_user,
        message: @user_message,
        history: @conversation.history,
        tray_recipe_ids: meal_plan&.recipe_ids || [],
        prep_day: @prep_day
      )
      @turn = @conversation.append(user_message: @user_message, reply: reply)
    rescue MealPlanAssistant::Error => e
      @error = e.message
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to meal_plan_assistant_path }
    end
  end

  # "Start over": clears the chat. Recipes already on the meal plan stay put.
  def destroy
    @conversation.clear
    redirect_to meal_plan_assistant_path, status: :see_other
  end

  private

  def set_prep_day_and_conversation
    @prep_day = MealPlanAssistant.prep_day_for(current_user)
    @conversation = MealPlanAssistant::Conversation.new(user: current_user, prep_day: @prep_day)
  end
end
