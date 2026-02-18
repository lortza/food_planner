require "#{Rails.root}/db/seeds_helper.rb"
include SeedsHelper

puts '**** Running seeds...'

user = User.find_or_create_by(email: 'admin@email.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.admin = true
end

# Recipes
puts "Seeding active recipes..."
15.times do
  begin
    FactoryBot.create(:recipe, :with_faker_data, :with_faker_ingredients, ingredients_count: 5, user: user)
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create recipe: #{e.message}"  
  end
end

# Pending Recipes
puts "Seeding pending recipes..."
5.times do
  begin
    FactoryBot.create(:recipe, :with_faker_data, user: user, status: :pending)
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create pending recipe: #{e.message}" 
  end
end

# Tags 
puts "Seeding tags..."
tag_names = ['breakfast', 'vegetarian', 'vegan', 'gluten-free', 'dairy-free', 'quick', 'slow-cooker', 'one-pot']
tag_names.each do |tag_name|
  begin
    user.tags.find_or_create_by!(name: tag_name)
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create tag: #{e.message}" 
  end
end

# Add random tags to each recipe
Recipe.all.each do |recipe|
  begin
    tag = user.tags.all.sample
    RecipeTag.create!(tag: tag, recipe: recipe)
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create recipe tag: #{e.message}"  
  end
end


# Meal Plans
puts "Seeding meal plans..."
7.times do |i|
  begin
    user.meal_plans.find_or_create_by!(
      prepared_on: i.weeks.ago.beginning_of_week(:sunday),
      people_served: [2, 4].sample,
      notes: ['plan to one of them in the freezer', '', '', ''].sample
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create meal plan: #{e.message}" 
  end
end

# Meal Plan Recipes
user.meal_plans.each do |meal_plan|
  # Add random recipes to each meal plan
  begin
    MealPlanRecipe.create!(
      user.recipes.all.sample(5).map{ |recipe| {recipe: recipe, meal_plan: meal_plan} }
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create meal plan recipe: #{e.message}"  
  end
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

shopping_list_item_names.each do |name|
  ShoppingListItem.find_or_create_by!(shopping_list: user.shopping_lists.default, name: name) do |item|
    item.aisle = user.aisles.sample
    item.quantity = (1..10).to_a.sample
    item.status = ['active', 'inactive'].sample
  end
end

# Notes
puts "Seeding notes..."
FactoryBot.create(:note, user: user, favorite: true, title: Faker::Lorem.sentence, content: Faker::Markdown.random)

3.times do
  begin
    FactoryBot.create(:note, user: user, title: Faker::Lorem.sentence, content: Faker::Markdown.random, favorite: [true, false].sample)
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create note: #{e.message}"  
  end
end

output_results
