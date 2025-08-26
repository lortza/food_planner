# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.2]
  def up
    create_table :tags do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :tags, [:user_id, :name], unique: true
  end
  
  def down  
    drop_table :tags
  end
end
