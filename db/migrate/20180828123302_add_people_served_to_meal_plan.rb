class AddPeopleServedToMealPlan < ActiveRecord::Migration[5.2]
  def change
    add_column :meal_plans, :people_served, :integer, null: false, default: 0
  end
end
