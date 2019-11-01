module SeedsHelper

  def check_for_existing_data!
    return unless User.any? || Recipe.any?
    message = %(
      FALED!
      Seeds were not run because there is already data in the database.
      To delete all data then replant seeds, run 'rake db:seed:replant'
      To reset the db and run seeds, run 'rake db:migrate:reset && rake db:seed'
      For more info, see: https://jacopretorius.net/2014/02/all-rails-db-rake-tasks-and-what-they-do.html
    )
    puts message
    raise 'ExistingDataError'
  end

  def assign_user_to_seed_data(seeds, user)
    seeds.each{|seed| seed[:user] = user}
  end

  def build_recipe_title_id_hash(seeds)
    # Creates hash with recipe title id like {"Title"=> id} to only query recipes once,
    # for finding missing recipes, and then assigning recipe_id to ingredients
    seeds
    .map{|i| i[:recipe_title]}
    .each_with_object({}) do |title, hash|
      hash[title] = Recipe.find_by(title: title)&.id
    end
  end

  def notify_if_missing_recipes(seeds, recipe_id_title_hash)
    missing_titles = recipe_id_title_hash.select{|_title, id| id.nil? }.keys
    return unless missing_titles.any?
    puts '😬 WARNING: Ingredients found for recipes that are not in the database: 😬'
    puts "#{missing_titles.join(', ')}"
    puts "😬 Ingredients for those recipes not created. You should update '/db/seed_fixtures/ingredients.yml' 😬"
  end

  def assign_recipe_to_seed_data(seeds, recipe_id_title_hash)
    seeds.each do |seed|
      seed[:recipe_id] = recipe_id_title_hash[seed[:recipe_title]]
      seed.except!(:recipe_title)
    end#.reject{ |seed| seed[:recipe_id].nil? }
  end

  def output_results
    puts "**** SUCCESS: Seeds have been created: ****"
    ApplicationRecord.descendants.each { |model| puts "#{model} count: #{model.count}" }
  end
end
