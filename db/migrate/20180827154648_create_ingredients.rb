class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, foreign_key: true
      t.float :quantity,            null: false, default: 0
      t.string :measurement_unit,   null: false, default: ''
      t.string :name,               null: false, default: ''
      t.string :preparation_style,  null: false, default: ''

      t.timestamps
    end
  end
end
