# frozen_string_literal: true

class MealPlan < ApplicationRecord
  has_many :meal_plan_recipes, dependent: :nullify
  has_many :recipes, through: :meal_plan_recipes

  def self.ordered
    all.order(start_date: :DESC)
  end

  def start_date_to_s
    start_date.strftime('%B %e, %Y')
  end
end
