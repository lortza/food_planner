class PopulateStatusData < ActiveRecord::Migration[6.0]
  def up
    ShoppingListItem.all.each do |item|
      status = item.purchased? ? 'inactive' : 'active'
      item.update!(status: status)
    end
  end

  def down
    ShoppingListItem.all.each do |item|
      item.update!(status: '')
    end
  end
end
