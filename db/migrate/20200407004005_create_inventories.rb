class CreateInventories < ActiveRecord::Migration[6.0]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.text :items

      t.timestamps
    end
  end
end
