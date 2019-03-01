class AddDefaultToRecipe < ActiveRecord::Migration[5.2]
  def up
    change_column :recipes, :reheat_time, :integer, default: 0
  end

  def down
    change_column :recipes, :reheat_time, :integer, default: nil
  end
end
