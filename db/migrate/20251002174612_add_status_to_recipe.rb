class AddStatusToRecipe < ActiveRecord::Migration[7.2]
  def change
    # Default of 1 sets all recipes to `active` on creation. 
    add_column :recipes, :status, :integer, default: 1, null: false
    add_index :recipes, :status
  end
end
