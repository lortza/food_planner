# frozen_string_literal: true

# run these tasks like:
# rake ingredients:task_name

namespace :ingredients do
  desc 'Convert cans to ounces'
  task cans_to_oz: :environment do
    puts 'Converting cans to ounces...'

    canned_food = Ingredient.where(measurement_unit: 'can')

    canned_food.each do |i|
      puts "#{i.quantity} #{i.measurement_unit} #{i.name}"
      i.quantity = i.quantity * 15
      i.measurement_unit = 'ounce'
      unless i.name.split().first == 'canned'
        i.name = "canned #{i.name}"
      end
      i.save
      puts "#{i.quantity} #{i.measurement_unit} #{i.name}"
    end
    puts 'Done'
  end
end
