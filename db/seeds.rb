require "#{Rails.root}/db/seeds_helper.rb"
include SeedsHelper

puts '**** Running seeds...'

user = User.find_or_create_by(email: 'admin@email.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.admin = true
end

# Recipes
puts "Seeding recipes..."
15.times do
  FactoryBot.create(:recipe, :with_faker_data, :with_faker_ingredients, ingredients_count: 5, user: user)
end

# Recipes to Try
puts "Seeding experimental recipes..."
5.times do
  FactoryBot.create(:experimental_recipe, :with_faker_data, user: user)
end

# Meal Plans
puts "Seeding meal plans..."
7.times do |i|
  user.meal_plans.find_or_create_by!(
    prepared_on: i.weeks.ago.beginning_of_week(:sunday),
    people_served: [2, 4].sample,
    notes: ['plan to one of them in the freezer', '', '', ''].sample
  )
end

# Meal Plan Recipes
user.meal_plans.each do |meal_plan|
  # Add random recipes to each meal plan
  MealPlanRecipe.create!(
    user.recipes.all.sample(5).map{ |recipe| {recipe: recipe, meal_plan: meal_plan} }
  )
end

# Aisles
puts "Seeding aisles..."
aisle_names = ['Unassigned', 'Produce: fruits', 'Produce: greens', 'Produce: vegetables',
               'Produce: potatoes & roots', 'Bakery', 'Deli', 'Prepared hot foods',
               'Canned foods', 'International', 'Snacks', 'Dairy', 'Frozen foods',
               'Cleaning supplies', 'Personal care']

order_number = 0
aisle_names.each do |aisle_name|
  user.aisles.find_or_create_by!(name: aisle_name, order_number: order_number)
  order_number += 10
end

# Shopping Lists
puts "Seeding shopping lists..."
user.shopping_lists.find_or_create_by!(name: 'grocery', main: true)

# Shopping List Items
shopping_list_item_names = ['apple', 'blueberries', 'salad greens', 'oat milk', 'sliced cheese', 'loaf of crusty bread', 'cereal', 'ground coffee']

ShoppingListItem.find_or_create_by!(
  shopping_list_item_names.map do |name|
    { shopping_list: user.shopping_lists.default,
      aisle: user.aisles.sample,
      quantity: (1..10).to_a.sample,
      name: name,
      status: ['active', 'inactive'].sample
    }
  end
)

output_results
