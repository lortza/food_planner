class AddOrderNumberToAisles < ActiveRecord::Migration[6.0]
  def change
    add_column :aisles, :order_number, :integer
  end
end
