class AddFavoriteToShoppingList < ActiveRecord::Migration[5.2]
  def change
    add_column :shopping_lists, :favorite, :boolean, default: false
  end
end
