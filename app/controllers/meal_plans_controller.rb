# frozen_string_literal: true

class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: %i[show edit update copy destroy]

  def index
    @meal_plans = current_user.meal_plans
                              .includes(:meal_plan_recipes, :recipes)
                              .most_recent_first
                              .paginate(page: params[:page], per_page: 30)
  end

  def show
    authorize(@meal_plan)

    @ingredient_set = IngredientSet.build_set(@meal_plan)
  end

  def new
    default_params = {
      people_served: 2,
      start_date: MealPlan.date_for_upcoming_sunday
    }
    @meal_plan = current_user.meal_plans.new(default_params)
    authorize(@meal_plan)
  end

  def copy
    flash[:warning] = 'This Meal Plan will not be created until you save.'
    existing_recipes = @meal_plan.recipes
    @meal_plan = @meal_plan.dup
    @meal_plan.recipes << existing_recipes
    @meal_plan.start_date = nil

    render :new
  end

  def create
    @meal_plan = current_user.meal_plans.new(meal_plan_params)
    authorize(@meal_plan)

    if @meal_plan.save
      redirect_to meal_plan_url(@meal_plan)
    else
      render :new
    end
  end

  def edit
    authorize(@meal_plan)
  end

  def update
    authorize(@meal_plan)

    if @meal_plan.update(meal_plan_params)
      redirect_to meal_plan_url(@meal_plan), notice: "#{@meal_plan.start_date} Meal Plan Updated"
    else
      render :edit
    end
  end

  def destroy
    meal_plan = MealPlan.find(params[:id])
    authorize(meal_plan)

    meal_plan.destroy
    flash[:success] = "#{meal_plan.start_date} Meal Plan deleted"
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
