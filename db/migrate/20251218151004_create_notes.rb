class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes, id: :uuid, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, default: ""
      t.text :content, null: false, default: ""
      t.boolean :favorite, null: false, default: false

      t.timestamps
    end
  end
end
