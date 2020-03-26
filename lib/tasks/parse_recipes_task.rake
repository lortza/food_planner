# frozen_string_literal: true

# run this task like:
# rake db:parse:recipes

namespace :db do
  namespace :parse do
    desc 'Parse recipe files'
    task recipes: :environment do
      puts 'Parsing recipe files...'

      # directory.each_file_do |file|
        source_file = Rails.root.join('lib', 'tasks', 'data', 'pepperplate_recipes', '1test_recipe.txt')
        RecipeParser.new(source_file).parse_recipe
      # end
    end # task
  end # parse
end # db
