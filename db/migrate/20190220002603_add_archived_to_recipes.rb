class AddArchivedToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :archived, :boolean, default: false
  end
end
