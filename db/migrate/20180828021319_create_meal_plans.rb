class CreateMealPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :meal_plans do |t|
      t.date :start_date, null: false

      t.timestamps
    end
  end
end
