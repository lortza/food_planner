class AddReheatTimeToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :reheat_time, :integer
  end
end
