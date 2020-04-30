class RemovePurchasedFromShoppingListItems < ActiveRecord::Migration[6.0]
  def up
    remove_column :shopping_list_items, :purchased
  end

  def down
    add_column :shopping_list_items, :purchased, :boolean

    ShoppingListItem.all.each do |item|
      item.update!(purchased: item.inactive?)
    end
  end
end
