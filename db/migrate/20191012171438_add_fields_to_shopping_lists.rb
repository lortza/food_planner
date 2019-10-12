class AddFieldsToShoppingLists < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_lists, :main, :boolean, default: false
    add_column :shopping_lists, :weekly, :boolean, default: false
    add_column :shopping_lists, :monthly, :boolean, default: false
  end
end
