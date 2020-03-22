# frozen_string_literal: true

# run this task like:
# rake db:parse:recipes

namespace :db do
  namespace :parse do
    desc 'Parse recipe files'
    task recipes: :environment do
      puts 'Parsing recipe files...'
      source_file = Rails.root.join('lib', 'tasks', 'data', 'pepperplate_recipes', '7VegetableandCheeseSoup.txt')

      user = User.find_by(admin: true)
      recipe = Recipe.new(user_id: user.id)

      IO.foreach(source_file) do |line|
        # text = line.match('\:(.*)')
        key = line.split(':')[0]&.strip
        text = line.split(":").drop(1).join.strip

        case key
        when 'Title'
          recipe.title = text
        when 'Description'
          recipe.notes = text
        when 'Source'
          recipe.source_name = text
        when 'Original URL'
          recipe.source_url = text
        when 'Yield'
          recipe.servings = text
        when 'Active'
          recipe.prep_time = text.to_i
        when 'Total'
          recipe.cook_time = text.to_i - recipe.prep_time
        when 'Image'
          recipe.image_url = text
        when 'Ingredients'
          puts 'handle ingredients here'
        when 'Instructions'
          recipe.instructions = text
          puts 'handle instructions here'
        else
          puts 'something else'
        end
      end # line
      p recipe

    end # task
  end # parse
end # db
