# frozen_string_literal: true

class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  has_many :ingredients, through: :recipes

  validates :start_date, :people_served, presence: true

  PREP_END_TIME = Time.zone.parse('5:00 PM')
  EFFICIENCY_RATE = 0.66

  def self.most_recent_first
    # TODO: scope to current_user
    order(start_date: :DESC)
  end

  def self.date_for_upcoming_sunday
    # TODO: scope to current_user
    closest_sunday = Date.parse('Sunday')
    days_to_add = closest_sunday > Time.zone.today ? 0 : 7
    closest_sunday + days_to_add
  end

  def self.future
    where('start_date >= ?', Time.zone.today).order(start_date: :asc)
  end

  def self.upcoming
    future.first
  end

  def total_servings
    recipes.pluck(:servings).reduce(:+)
  end

  def total_prep_time
    recipes.pluck(:prep_time).reduce(:+)
  end

  def total_cook_time
    recipes.pluck(:cook_time).reduce(:+)
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
  #     @recipe_queue << add_to_calendar_url(@start_date)
  #   end
  #   @recipe_queue.count
  # end
end
