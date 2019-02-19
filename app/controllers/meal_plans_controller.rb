# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: [:show, :edit, :update, :destroy]

  def index
    @meal_plans = MealPlan.includes(:recipes).most_recent_first
  end

  def show
    @ingredient_set = IngredientSet.build_set(@meal_plan)
  end

  def new
    default_params = {
      people_served: 2,
      start_date: MealPlan.date_for_upcoming_sunday
    }
    @meal_plan = MealPlan.new(default_params)
  end

  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    if @meal_plan.save
      redirect_to meal_plan_url(@meal_plan)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meal_plan.update(meal_plan_params)
      redirect_to meal_plan_url(@meal_plan), notice: 'Meal Plan Updated'
    else
      render :edit
    end
  end

  def destroy
    MealPlan.find(params[:id]).destroy
    flash[:success] = "Meal Plan deleted"
    redirect_to meal_plans_path
  end

  private

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:id])
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:start_date, :people_served, recipe_ids: [])
  end
end
