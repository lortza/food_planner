# frozen_string_literal: true

class CreateRecipesTags < ActiveRecord::Migration[7.2]
  def change
    create_table :recipe_tags do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recipe_tags, [:recipe_id, :tag_id], unique: true
  end
end
