require "#{Rails.root}/db/seeds_helper.rb"
include SeedsHelper

check_for_existing_data!

puts '**** Running seeds...'

user = User.create!(
        email: 'admin@email.com',
        password: 'password',
        password_confirmation: 'password',
        admin: true
      )

# Recipes
recipe_data = YAML::load_file("#{Rails.root}/db/seed_fixtures/recipes.yml")
processed_recipe_data = assign_user_to_seed_data(recipe_data, user)
Recipe.create!(processed_recipe_data)

# Ingredients
ingredient_data = YAML::load_file("#{Rails.root}/db/seed_fixtures/ingredients.yml")
recipe_hash = build_recipe_title_id_hash(ingredient_data)
notify_if_missing_recipes(ingredient_data, recipe_hash)
processed_ingredient_data = assign_recipe_to_seed_data(ingredient_data, recipe_hash).reject{ |seed| seed[:recipe_id].nil? }
Ingredient.create!(processed_ingredient_data)

# Recipes to Try
experimental_recipe_seed_data = YAML::load_file("#{Rails.root}/db/seed_fixtures/experimental_recipes.yml")
processed_experimental_recipe_seed_data = assign_user_to_seed_data(experimental_recipe_seed_data, user)
ExperimentalRecipe.create!(experimental_recipe_seed_data)

# Meal Plans
7.times do |i|
  MealPlan.create!(
    user: user,
    prepared_on: i.weeks.ago.beginning_of_week(:sunday),
    people_served: [2, 4].sample,
    notes: ['plan to one of them in the freezer', '', '', ''].sample
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

order_number = 0
aisle_names.each do |aisle_name|
  Aisle.create!(name: aisle_name, user: user, order_number: order_number)
  order_number += 10
end

# Shopping Lists
ShoppingList.create!(name: 'grocery', main: true, user: user)

# Shopping List Items
shopping_list_item_names = ['apple', 'blueberries', 'salad greens', 'bulb of fennel']

ShoppingListItem.create!(
  shopping_list_item_names.map do |name|
    { shopping_list: user.shopping_lists.default,
      aisle: user.aisles.sample,
      quantity: [1, 2].sample,
      name: name,
      status: ['active', 'inactive'].sample
    }
  end
)

output_results
