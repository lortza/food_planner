# frozen_string_literal: true

# run these tasks like:
# rake shopping_list:task_name

namespace :shopping_list do

  desc 'Add HEB aisles'
  task add_weekly_items: :environment do
    # Heroku runs this daily at 6am UTC / 1am CST: https://dashboard.heroku.com/apps/myfoodplanner/scheduler
    # UTC is 5 hours ahead of Central Time: https://savvytime.com/converter/utc-to-cst
    if Date.today.tuesday?
      puts "It's Tuesday!"
      user = User.find_by(admin: true)
      weekly_items_list = user.shopping_lists.find_by(name: 'weekly items')
      grocery_list = user.shopping_lists.find_by(name: 'grocery')

      puts "Adding #{weekly_items_list.name} to #{grocery_list.name} list..."
      weekly_items_list.items.each do |item|
        incoming_item = item.dup
        puts incoming_item.name
        if grocery_list.items.map(&:name).include?(incoming_item.name)
          existing_item = grocery_list.items.find_by(name: incoming_item.name)
          updated_quantity = existing_item.quantity + incoming_item.quantity
          updated_quantity = incoming_item.quantity if existing_item.purchased?
          existing_item.update(quantity: updated_quantity, purchased: false)
        else
          incoming_item.purchased = false
          grocery_list.items << incoming_item
        end
      end
    else
      puts "It's not Tuesday. Don't add items to the list today."
    end
  end


  desc 'Add HEB aisles'
  task heb_aisles: :environment do
    # rake shopping_list:heb_aisles
    puts 'Adding HEB aisles...'

    user = User.find_by(email: 'richardson.ae@gmail.com')

    Aisle.create!([
      { user_id: user.id, name: "0: Customer Service" },
      { user_id: user.id, name: "0.0: Prepared Hot Foods" },
      { user_id: user.id, name: "0.1.1: Produce - Fruits" },
      { user_id: user.id, name: "0.1.1: Produce - Tofu/Protein" },
      { user_id: user.id, name: "0.1.2: Produce - Side Wall: Greens & Organics" },
      { user_id: user.id, name: "0.1.2: Produce - Veg & Peppers" },
      { user_id: user.id, name: "0.1.3: Produce - Tubers,Onions, Nuts, Exotic" },
      { user_id: user.id, name: "0.2: Bakery" },
      { user_id: user.id, name: "0.2: Deli Cheeses" },
      { user_id: user.id, name: "0.3.1: Healthy Living" },
      { user_id: user.id, name: "0.3.2: Bulk (bring container)" },
      { user_id: user.id, name: "1: Bread & PB&J" },
      { user_id: user.id, name: "1.20: Beer & Wine" },
      { user_id: user.id, name: "2: Pickles & Condiments" },
      { user_id: user.id, name: "2.wall: Organic Dairy" },
      { user_id: user.id, name: "3: Ethnic" },
      { user_id: user.id, name: "4: Soups / Pasta" },
      { user_id: user.id, name: "4.wall Sliced Cheese" },
      { user_id: user.id, name: "5: Canned Beans / Veg / Tomato" },
      { user_id: user.id, name: "5.wall: Shredded/Sliced Cheeses" },
      { user_id: user.id, name: "6: Baking/Spices" },
      { user_id: user.id, name: "7: Kitchen Tools" },
      { user_id: user.id, name: "7.wall Ethnic Cheeses" },
      { user_id: user.id, name: "8: Cereal" },
      { user_id: user.id, name: "8: Soaps" },
      { user_id: user.id, name: "9: Dried Fruits" },
      { user_id: user.id, name: "10: Snacks - Botanas" },
      { user_id: user.id, name: "11: Tea" },
      { user_id: user.id, name: "12: Chocolate / Juices / Nut Milks" },
      { user_id: user.id, name: "13: Coconut Water" },
      { user_id: user.id, name: "15: Frozen Novelties" },
      { user_id: user.id, name: "16: Frozen Vegetables" },
      { user_id: user.id, name: "16.5: Veggie Burgers" },
      { user_id: user.id, name: "17: Dairy Cheese Wall" },
      { user_id: user.id, name: "24: Greeting Cards" },
      { user_id: user.id, name: "28: Office Supplies" },
      { user_id: user.id, name: "29: Cleaning Supplies" },
      { user_id: user.id, name: "31: Household Soaps" },
      { user_id: user.id, name: "32: Plastic Disposables" },
      { user_id: user.id, name: "33: Paper Products" },
      { user_id: user.id, name: "37: Body Care" },
      { user_id: user.id, name: "38: Oral Care" },
      { user_id: user.id, name: "40: Corazon Peludo" },
      { user_id: user.id, name: "42: Meds & Misc Shoe Needs" },
      { user_id: user.id, name: "43: Clothing" },
      { user_id: user.id, name: "45: Meds" },
      { user_id: user.id, name: "46: Meds" },
      { user_id: user.id, name: "Ace" },
      { user_id: user.id, name: "Borrow" },
      { user_id: user.id, name: "Buy" },
      { user_id: user.id, name: "Can We Find This?" },
      { user_id: user.id, name: "Car" },
      { user_id: user.id, name: "Central Market" },
      { user_id: user.id, name: "CHECK STOCK" },
      { user_id: user.id, name: "Craigslist" },
      { user_id: user.id, name: "Errands" },
      { user_id: user.id, name: "Farmer's Market" },
      { user_id: user.id, name: "Fresh Plus (Duval)" },
      { user_id: user.id, name: "Goodwill" },
      { user_id: user.id, name: "Helper Vocab" },
      { user_id: user.id, name: "Info" },
      { user_id: user.id, name: "Natural Grocers" },
      { user_id: user.id, name: "TAKE OUT OF FREEZER" },
    ])
    puts 'Done'
  end
end
