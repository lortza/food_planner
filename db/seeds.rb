# Check for existing data
if User.any? || Recipe.any?
  message = %(
    FALED!
    Seeds were not run because there is already data in the database.
    To delete all data then replant seeds, run 'rake db:seed:replant'
    To reset the db and run seeds, run 'rake db:migrate:reset && rake db:seed'
    For more info, see: https://jacopretorius.net/2014/02/all-rails-db-rake-tasks-and-what-they-do.html
  )
 puts message
 return
end

puts '**** Running seeds...'

user = User.create!(
        email: 'admin@email.com',
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )

# Recipes
recipe_seed_data = YAML::load_file("#{Rails.root}/db/seed_fixtures/recipes.yml")
               .each{|seed| seed[:user] = user}

Recipe.create!(recipe_seed_data)

# Ingredients
ingredient_seed_data = YAML::load_file("#{Rails.root}/db/seed_fixtures/ingredients.yml")
# Create a hash where the title is the recipe title, and the value is that recipe's id.
recipe_hash = ingredient_seed_data
               .map{|i| i[:recipe_title]}.map.each_with_object({}) do |title, hash|
                 hash[title] = Recipe.find_by(title: title)&.id
                end
missing_titles = recipe_hash.select{|_title, id| id.nil? }.keys
if missing_titles.any?
  puts "😬 WARNING 😬: Ingredients found for recipes that are not in the database: #{missing_titles.join(', ')}"
  puts "😬 Ingredients for those recipes not created. You should update '/db/seed_fixtures/ingredients.yml' 😬"
end
ingredient_seed_data = ingredient_seed_data.each do |seed|
                          seed[:recipe_id] = recipe_hash[seed[:recipe_title]]
                          seed.except!(:recipe_title)
                        end.reject{|seed| seed[:recipe_id].nil? }
Ingredient.create!(ingredient_seed_data)

# Recipes to Try
expermimental_recipe_seed_data = YAML::load_file(
                              "#{Rails.root}/db/seed_fixtures/experimental_recipes.yml"
                              ).each{ |seed| seed[:user] = user }

ExperimentalRecipe.create!(expermimental_recipe_seed_data)


# Meal Plans
7.times do |i|
  MealPlan.create!(
    user: user,
    start_date: i.weeks.ago.beginning_of_week(:sunday),
    people_served: [2, 4].sample
  )
end

# Meal Plan Recipes
MealPlan.all.each do |meal_plan|
  # Add random recipes to each meal plan
  MealPlanRecipe.create!(
    Recipe.all.sample(5).map{ |recipe| {recipe: recipe, meal_plan: meal_plan} }
  )
end

# Aisles
aisle_names = ['Unassigned', 'produce: fruits', 'produce: greens', 'produce: peppers',
               'produce: vegetables', 'produce: potatoes & roots', 'bread & tortillas']

Aisle.create!(aisle_names.map{ |name| {name: name, user: user} })

# Shopping Lists
ShoppingList.create!(name: 'grocery', main: true, user: user)

# Shopping List Items
shopping_list_item_names = ['apple', 'blueberries', 'salad greens', 'bulb of fennel']

ShoppingListItem.create!(
  shopping_list_item_names.map do |name|
    { shopping_list: ShoppingList.default(user),
      aisle: user.aisles.sample,
      quantity: [1, 2].sample,
      name: name
    }
  end
)

# Output results
puts "**** SUCCESS: Seeds created successfully: ****"
models = %w[User Recipe Ingredient ExperimentalRecipe MealPlan MealPlanRecipe Aisle ShoppingList ShoppingListItem]

models.each { |model| puts "#{model} count: #{model.constantize.count}" }
