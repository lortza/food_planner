class AddLastPreparedOnToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :last_prepared_on, :date
  end
end
