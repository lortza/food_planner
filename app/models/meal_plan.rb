# frozen_string_literal: true

class MealPlan < ApplicationRecord
  has_many :meal_plan_recipes, dependent: :nullify
  has_many :recipes, through: :meal_plan_recipes

end
