# frozen_string_literal: true

namespace :ingredients do
  # run these tasks like:
  # rake 'ingredients:rename_unit["TBS", "tablespoon"]'

  desc "Convert all instance of ingredient's matching measurement unit to new name"
  task :rename_unit, [:current_name, :new_name] => [:environment] do |t, args|
    puts "Changing all instances of ingredient current unit '#{args[:current_name]}' to '#{args[:new_name]}'"

    ingredients = Ingredient.where("measurement_unit = ?", args[:current_name])

    if ingredients.length.zero?
      puts "No matching ingredients to update."
    else
      ingredients.each { |i| i.update(measurement_unit: args[:new_name]) }
      updated = Ingredient.where("measurement_unit = ?", args[:new_name])
      puts "Updated #{updated.length} ingredients."
    end
  end

  desc "Convert cans to ounces"
  # rake ingredients:cans_to_oz
  task cans_to_oz: :environment do
    puts "Converting cans to ounces..."
    canned_food = Ingredient.where(measurement_unit: "can")

    canned_food.each do |i|
      puts "#{i.quantity} #{i.measurement_unit} #{i.name}"
      i.quantity = i.quantity * 15
      i.measurement_unit = "ounce"
      unless i.name.split.first == "canned"
        i.name = "canned #{i.name}"
      end
      i.save
      puts "#{i.quantity} #{i.measurement_unit} #{i.name}"
    end
    puts "Done"
  end
end

namespace :shopping_list_items do
  # run these tasks like:
  # rake 'shopping_list_items:rename_unit["TBS", "tablespoon"]'

  desc "Convert all instance of list item's matching measurement unit to new name"
  task :rename_unit, [:current_name, :new_name] => [:environment] do |t, args|
    puts "Changing all instances of item current unit '#{args[:current_name]}' to '#{args[:new_name]}'"

    items = ShoppingListItem.where("name LIKE ?", "#{args[:current_name]} %")
    if items.length.zero?
      puts "No matching shopping list items to update."
    else
      items.map do |item|
        updated_name = item.name.gsub(args[:current_name], args[:new_name])
        item.update(name: updated_name)
      end

      remaining_old_name_records = ShoppingListItem.where("name LIKE ?", "#{args[:current_name]} %")
      updated_records = ShoppingListItem.where("name LIKE ?", "#{args[:new_name]} %")

      puts "Updated #{updated_records.length} records. #{remaining_old_name_records.length} records remaining."
    end
  end
end
