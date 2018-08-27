class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title,        null: false, default: ''
      t.string :source_name,  null: false, default: ''
      t.string :source_url,   null: false, default: ''
      t.integer :servings,    null: false, default: 0
      t.text :instructions,   null: false, default: ''

      t.timestamps
    end
  end
end
