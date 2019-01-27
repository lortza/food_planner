class AddImageUrlToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :image_url, :string, null: false, default: ""
  end
end
