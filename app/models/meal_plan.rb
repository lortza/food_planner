# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  has_many :ingredients, through: :recipes

  validates :people_served, presence: true
  validates :prepared_on,
            presence: true,
            uniqueness: { scope: :user_id }

  after_update :update_recipes_last_prepared_dates

  PREP_END_TIME = Time.zone.parse('5:00 PM')
  EFFICIENCY_RATE = 0.66

  scope :by_date, -> { order(prepared_on: :asc) }
  scope :most_recent_first, -> { order(prepared_on: :DESC) }

  def self.future
    where('prepared_on >= ?', Time.zone.today).by_date
  end

  def self.upcoming
    future.first
  end

  def self.suggested_date(user)
    upcoming_sunday = Date.today.next_occurring(:sunday)
    return upcoming_sunday if user.meal_plans.blank?

    latest_plan_date = user.meal_plans.maximum(:prepared_on)
    oldest_allowable_date = 7.days.ago

    if latest_plan_date < oldest_allowable_date
      upcoming_sunday
    else
      date_after_last_meal_plan(latest_plan_date)
    end
  end

  def self.date_after_last_meal_plan(latest_plan_date)
    latest_plan_day_of_week = latest_plan_date.wday
    days_to_add = (7 - latest_plan_day_of_week)
    latest_plan_date + days_to_add
  end

  def total_servings
    recipes.pluck(:servings).reduce(:+) || 0
  end

  def total_prep_time
    recipes.pluck(:prep_time).reduce(:+) || 0
  end

  def total_cook_time
    recipes.pluck(:cook_time).reduce(:+) || 0
  end

  def total_time
    total_prep_time + total_cook_time
  end

  def estimated_time
    (total_time * efficiency_rate).to_i
  end

  def recommended_start_time
    (prep_end_time - estimated_time * 60).strftime('%I:%M %p')
  end

  def total_unique_ingredients
    # Option 1: SQL is faster
    # Ingredient.select(:name).distinct
    #           .joins('INNER JOIN recipes ON recipes.id = ingredients.recipe_id')
    #           .joins('INNER JOIN meal_plan_recipes ON meal_plan_recipes.recipe_id = recipes.id')
    #           .joins('INNER JOIN meal_plans ON meal_plans.id = meal_plan_recipes.meal_plan_id')
    #           .where("meal_plan_id = #{id}").count

    # Option 2: Reuses code
    IngredientSet.build_set(self).count
  end

  def meals
    total_servings / people_served
  end

  private

  def efficiency_rate
    EFFICIENCY_RATE
  end

  def prep_end_time
    PREP_END_TIME
  end

  def update_recipes_last_prepared_dates
    recipes.each do |recipe|
      date = recipe.calculate_last_prepared_on
      recipe.update_columns(last_prepared_on: date)
    end
  end

  # def add_to_calendar_url(date)
  #   [
  #     'http://www.google.com/calendar/event?action=TEMPLATE',
  #     "&text=#{@recipe.title}",
  #     "&dates=20180823/#{date}",
  #     "&details=#{@recipe.url}",
  #     '&trp=false',
  #     '&sprop=',
  #     '&sprop=name:'
  #   ].join
  # end
  #
  # def enqueue_recipes
  #   qty_meals.times do
  #     @recipe_queue << add_to_calendar_url(@prepared_on)
  #   end
  #   @recipe_queue.count
  # end
end
