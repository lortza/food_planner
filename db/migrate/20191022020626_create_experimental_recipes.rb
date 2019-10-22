class CreateExperimentalRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :experimental_recipes do |t|
      t.string :title
      t.string :source_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
