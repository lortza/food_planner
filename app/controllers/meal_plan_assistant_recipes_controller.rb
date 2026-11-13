# frozen_string_literal: true

# The "This week" tray on the meal plan assistant page. The tray is the meal
# plan for the upcoming prep day: adding the first recipe creates that plan,
# and removing a recipe takes it off the plan.
class MealPlanAssistantRecipesController < ApplicationController
  DEFAULT_PEOPLE_SERVED = 2

  before_action :set_prep_day

  def create
    recipe = current_user.recipes.active.find(params[:recipe_id])
    @meal_plan = current_user.meal_plans.find_or_create_by!(prepared_on: @prep_day) do |meal_plan|
      meal_plan.people_served = DEFAULT_PEOPLE_SERVED
    end
    @meal_plan.recipes << recipe unless @meal_plan.recipes.include?(recipe)

    render_tray
  end

  def destroy
    @meal_plan = MealPlanAssistant.meal_plan_for(current_user, prep_day: @prep_day)
    recipe = @meal_plan&.recipes&.find_by(id: params[:id])
    @meal_plan.recipes.delete(recipe) if recipe

    render_tray
  end

  private

  def set_prep_day
    @prep_day = MealPlanAssistant.prep_day_for(current_user)
  end

  def render_tray
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "assistant_tray",
          partial: "meal_plan_assistants/tray",
          locals: {meal_plan: @meal_plan, prep_day: @prep_day}
        )
      end
      format.html { redirect_to meal_plan_assistant_path }
    end
  end
end
