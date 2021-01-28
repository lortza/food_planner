class ChangeMealPlanStartDateColumnName < ActiveRecord::Migration[6.0]
  def up
    rename_column :meal_plans, :start_date, :prepared_on
  end

  def down
    rename_column :meal_plans, :prepared_on, :start_date
  end
end
