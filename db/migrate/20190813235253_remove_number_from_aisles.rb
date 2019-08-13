class RemoveNumberFromAisles < ActiveRecord::Migration[5.2]
  def up
    remove_column :aisles, :number
  end

  def down
    add_column :aisles, :number, :string
  end
end
