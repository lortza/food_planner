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
recipe_seeds = YAML::load_file("#{Rails.root}/db/seed_fixtures/recipes.yml")
               .each{|seed| seed[:user] = user}

Recipe.create!(recipe_seeds)

# Ingredients
ingredient_seeds = YAML::load_file("#{Rails.root}/db/seed_fixtures/ingredients.yml")
ingredient_seeds.each do |seed|
  seed[:recipe] = Recipe.find_by(title: seed[:recipe_title])
  seed.except!(:recipe_title)
end


Ingredient.create!(ingredient_seeds)

# Recipes to Try
expermimental_recipe_seeds = YAML::load_file(
                              "#{Rails.root}/db/seed_fixtures/experimental_recipes.yml"
                              ).each{ |seed| seed[:user] = user }

ExperimentalRecipe.create!(expermimental_recipe_seeds)


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
puts "**** Seeds Seeded ****"
models = %w[User Recipe Ingredient ExperimentalRecipe MealPlan MealPlanRecipe Aisle ShoppingList ShoppingListItem]

models.each { |model| puts "#{model} count: #{model.constantize.count}" }
