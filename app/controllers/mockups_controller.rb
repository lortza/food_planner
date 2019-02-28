# frozen_string_literal: true

class MockupsController < ApplicationController
  # These are temporary pages to help me figure out what the UX should be.
  # Since I'm not sure how I want to use the app, I'm not sure how to
  # build the back end.

  def recipes
    # randomly generated temporaty placeholder recipes
    @recipes = current_user.recipes.by_title
    @upcoming_meal_plans = MealPlan.upcoming
  end

  # def shopping_lists
  # end

  # def add_to_prep_plan
  # end
end
