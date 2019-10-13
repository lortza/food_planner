class RemoveBooleansFromShoppingLists < ActiveRecord::Migration[6.0]
  def up
    remove_column :shopping_lists, :weekly, :boolean
    remove_column :shopping_lists, :monthly, :boolean
  end

  def down
    add_column :shopping_lists, :weekly, :boolean, default: false
    add_column :shopping_lists, :monthly, :boolean, default: false
  end
end
