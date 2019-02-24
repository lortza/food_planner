class AddUserToMealPlans < ActiveRecord::Migration[5.2]
  def change
    add_reference :meal_plans, :user, foreign_key: true
  end
end
