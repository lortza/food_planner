class AddNullConstraintToListItemStatus < ActiveRecord::Migration[6.0]
  def up
    # Do not allow null values
    change_column_null :shopping_list_items, :status, false
  end

  def down
    # Allow null values
    change_column_null :shopping_list_items, :status, true
  end
end
