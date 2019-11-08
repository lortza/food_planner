class AddUpcToShoppingListItems < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_list_items, :heb_upc, :string
  end
end
