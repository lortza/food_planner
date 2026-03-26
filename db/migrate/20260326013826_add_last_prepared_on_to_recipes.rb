class AddLastPreparedOnToRecipes < ActiveRecord::Migration[8.1]
  def change
    add_column :recipes, :last_prepared_on, :date, if_not_exists: true
  end
end
