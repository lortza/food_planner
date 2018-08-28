# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: [:show]

  def index
    @meal_plans = MealPlan.ordered
  end

  def show
    @ingredient_set = IngredientSet.build_set(@meal_plan)
  end

  private

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:id])
  end

  def meail_plan_params
    params.require(:meal_plan).permit(:start_date)
  end
end
