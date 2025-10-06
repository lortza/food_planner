class ConvertExperimentalRecipesToPendingRecipes < ActiveRecord::Migration[7.2]
  def up
    ExperimentalRecipe.all.each do |experimental_recipe|
      Recipe.create(
        title: experimental_recipe.title,
        source_name: URI.parse(experimental_recipe.source_url).host.gsub("www.", ""),
        source_url: experimental_recipe.source_url,
        image_url: experimental_recipe.image_url,
        instructions: Scraper.new(experimental_recipe.source_url).site_data,
        user_id: experimental_recipe.user.id,
        created_at: experimental_recipe.created_at,
        status: :pending
      )
      experimental_recipe.destroy
    end
  end

  def down
    Recipe.where(status: :pending).each do |recipe|
      ExperimentalRecipe.create(
        title: recipe.title,
        source_url: recipe.source_url,
        image_url: recipe.image_url,
        user_id: recipe.user.id
      )
      recipe.destroy
    end
  end
end
