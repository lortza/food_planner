class AddPrepTimeToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :prep_time, :integer, null: false, default: 0
    add_column :recipes, :cook_time, :integer, null: false, default: 0
  end
end
