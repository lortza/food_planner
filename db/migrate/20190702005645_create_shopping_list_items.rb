class CreateShoppingListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_list_items do |t|
      t.references :shopping_list, foreign_key: true
      t.references :aisle, foreign_key: true
      t.float :quantity
      t.string :name
      t.boolean :purchased

      t.timestamps
    end
  end
end
