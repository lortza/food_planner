# frozen_string_literal: true

class MockupsController < ApplicationController
  def recipes
    # randomly generated temporaty placeholder recipes
    @recipes = Recipe.by_title
    @prep_plan_recipes = Recipe.all.sample(5)
  end
end
