class AddDefaultToShoppingListItem < ActiveRecord::Migration[5.2]
  def change
    change_column :shopping_list_items, :purchased, :boolean, :default => false
  end
end
