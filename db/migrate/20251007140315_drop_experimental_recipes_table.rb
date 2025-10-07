class DropExperimentalRecipesTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :experimental_recipes if table_exists?(:experimental_recipes)
  end
  
  def down
    unless table_exists?(:experimental_recipes)
      create_table :experimental_recipes do |t|
        t.string :title
        t.string :source_url
        t.references :user, null: false, foreign_key: true
    
        t.timestamps
      end
    end
  end
end
