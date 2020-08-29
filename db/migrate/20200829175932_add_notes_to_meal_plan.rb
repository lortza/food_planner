class AddNotesToMealPlan < ActiveRecord::Migration[6.0]
  def change
    add_column :meal_plans, :notes, :text
  end
end
