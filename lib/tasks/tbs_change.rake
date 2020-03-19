# frozen_string_literal: true

# run these tasks like:
# rake ingredients:task_name

namespace :tbs do
  desc 'Convert ingredient T to TBS'
  task ingredients: :environment do
    puts 'Converting ingredients'

    ingredients = Ingredient.where(measurement_unit: 'T')
    ingredients.each { |i| i.update(measurement_unit: 'TBS') }

    updated_ingredients = Ingredient.where(measurement_unit: 'TBS')
    puts updated_ingredients.count
  end

  desc 'Convert list items T to TBS'
  task items: :environment do
    puts 'Converting list items'

    items = ShoppingListItem.where('name LIKE ?', 'T %')
    puts items.count

    items.each do |item|
      chars_array = item.name.chars.drop(1)
      updated_name = chars_array.unshift('TBS').join
      item.update(name: updated_name)
      puts item.name
    end
    puts 'done'
  end
end
