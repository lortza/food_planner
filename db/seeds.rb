puts 'Running seeds...'

user = User.create!(
        email: 'admin@email.com',
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )

recipe_seeds = YAML::load_file("#{Rails.root}/db/seed_fixtures/recipes.yml")
recipe_seeds.each{|seed| seed[:user] = user}

Recipe.create!(recipe_seeds)


ingredient_seeds = YAML::load_file("#{Rails.root}/db/seed_fixtures/ingredients.yml")
ingredient_seeds.each do |seed|
  seed[:recipe] = Recipe.find_by(title: seed[:recipe_title])
  seed.except!(:recipe_title)
end


Ingredient.create!(ingredient_seeds)

# Recipes to Try
user.experimental_recipes.create!([
  { title: 'Sesame Tempeh Bowls', source_url: 'https://www.budgetbytes.com/sesame-tempeh-bowls/' },
  { title: 'Mushroom Tacos', source_url: 'https://www.pepperplate.com/recipes/view.aspx?id=15772708' },
  { title: 'Old Pepperplate recipes', source_url: 'https://docs.google.com/spreadsheets/d/1sJ52kWpNq28rNRLHCXP6tdkyCrBb0nuaRH40Z0Nib_0/edit#gid=0' },
  { title: 'Smoky tempeh tacos', source_url: 'https://www.emilieeats.com/smoky-tempeh-tostadas-mango-cabbage-slaw/' },
  { title: 'BLTs', source_url: 'https://frommybowl.com/vegan-blt-sandwiches/' },
])


# Meal Plans
7.times do |i|
  MealPlan.create!(
    user: user,
    start_date: i.weeks.ago.beginning_of_week(:sunday),
    people_served: [2, 4].sample
  )
end

# Add random recipes to each meal plan
MealPlan.all.each do |meal_plan|
  MealPlanRecipe.create!(Recipe.all.sample(5).map{ |recipe| {recipe: recipe, meal_plan: meal_plan} })
end

# Shopping Lists
Aisle.create!([
  { user_id: user.id, name: 'Unassigned' },
  { user_id: user.id, name: 'produce: fruits' },
  { user_id: user.id, name: 'produce: greens' },
  { user_id: user.id, name: 'produce: peppers' },
  { user_id: user.id, name: 'produce: vegetables' },
  { user_id: user.id, name: 'produce: potatoes & roots' },
  { user_id: user.id, name: 'bread & tortillas' },
])

shopping_list = user.shopping_lists.create(name: 'grocery', main: true)

ShoppingListItem.create!([
  { shopping_list_id: shopping_list.id, aisle_id: user.aisles.first.id, quantity: 2, name: 'apple' },
  { shopping_list_id: shopping_list.id, aisle_id: user.aisles.first.id, quantity: 1, name: 'blueberries' },
  { shopping_list_id: shopping_list.id, aisle_id: user.aisles.second.id, quantity: 1, name: 'salad greens' },
  { shopping_list_id: shopping_list.id, aisle_id: user.aisles.second.id, quantity: 1, name: 'bulb of fennel' },
])

puts "******** SEEDED *******"
models = %w[User Recipe Ingredient ExperimentalRecipe MealPlan MealPlanRecipe Aisle ShoppingList ShoppingListItem]

models.each { |model| puts "#{model} count: #{model.constantize.count}" }
