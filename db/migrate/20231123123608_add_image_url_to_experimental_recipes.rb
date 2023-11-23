class AddImageUrlToExperimentalRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :experimental_recipes, :image_url, :string
  end
end
