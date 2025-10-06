class DropArchivedFromRecipes < ActiveRecord::Migration[7.2]
  def up
    remove_column(:recipes, :archived, if_exists: true)
  end

  def down
    # enum status: {pending: 0, active: 1, archived: 2}
    add_column(:recipes, :archived, :boolean, default: false, null: false) unless column_exists?(:recipes, :archived)
    Recipe.where(status: 2).update_all(archived: true)
  end
end
