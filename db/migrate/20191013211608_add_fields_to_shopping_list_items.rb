class AddFieldsToShoppingListItems < ActiveRecord::Migration[6.0]
  def change
    add_column :shopping_list_items, :recurrence_frequency, :string, default: nil
    add_column :shopping_list_items, :recurrence_quantity, :float, default: 0.0
  end
end
