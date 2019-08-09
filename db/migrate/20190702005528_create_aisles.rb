class CreateAisles < ActiveRecord::Migration[5.2]
  def change
    create_table :aisles do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
