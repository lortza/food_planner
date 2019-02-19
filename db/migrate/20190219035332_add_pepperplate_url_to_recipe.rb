class AddPepperplateUrlToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :pepperplate_url, :string
    add_column :recipes, :notes, :text
  end
end
