# frozen_string_literal: true

module UserSetup
  def self.populate_shopping_lists(user)
    user.shopping_lists.find_or_create_by!(name: 'Grocery') do |list|
      list.favorite = true
      list.save
    end
  end

  def self.populate_aisles(user)
    default_aisles = [
      { name: "Customer Service", order_number: 10 },
      { name: "Prepared Hot Foods", order_number: 20 },
      { name: "Produce - Fruits", order_number: 30 },
      { name: "Produce - Tofu/Protein", order_number: 40 },
      { name: "Produce - Side Wall: Greens & Organics", order_number: 50 },
      { name: "Produce - Veg & Peppers", order_number: 60 },
      { name: "Bakery", order_number: 80 },
      { name: "Produce - Tubers,Onions, Nuts, Exotic", order_number: 70 },
      { name: "Deli Cheeses", order_number: 90 },
      { name: "Healthy Living", order_number: 100 },
      { name: "Bulk (bring container)", order_number: 110 },
      { name: "1: Bread & PB&J", order_number: 120 },
      { name: "1: Beer & Wine", order_number: 130 },
      { name: "2: Pickles & Condiments", order_number: 140 },
      { name: "2: Organic Dairy", order_number: 150 },
      { name: "3: Ethnic", order_number: 160 },
      { name: "4: Soups / Pasta", order_number: 170 },
      { name: "4: Sliced Cheese", order_number: 180 },
      { name: "5: Canned Beans / Veg / Tomato", order_number: 190 },
      { name: "5: Shredded/Sliced Cheeses", order_number: 200 },
      { name: "6: Baking/Spices", order_number: 210 },
      { name: "7: Kitchen Tools", order_number: 220 },
      { name: "7: Ethnic Cheeses", order_number: 230 },
      { name: "8: Cereal", order_number: 240 },
      { name: "8: Soaps", order_number: 250 },
      { name: "9: Dried Fruits", order_number: 260 },
      { name: "10: Snacks", order_number: 270 },
      { name: "11: Tea", order_number: 280 },
      { name: "12: Chocolate / Juices / Nut Milks", order_number: 290 },
      { name: "13: Coconut Water", order_number: 300 },
      { name: "15: Frozen Novelties", order_number: 310 },
      { name: "16: Frozen Vegetables", order_number: 320 },
      { name: "17: Dairy Cheese Wall", order_number: 340 },
      { name: "24: Greeting Cards", order_number: 350 },
      { name: "28: Office Supplies", order_number: 360 },
      { name: "29: Cleaning Supplies", order_number: 370 },
      { name: "31: Household Soaps", order_number: 380 },
      { name: "32: Plastic Disposables", order_number: 390 },
      { name: "33: Paper Products", order_number: 400 },
      { name: "37: Body Care", order_number: 410 },
      { name: "38: Oral Care", order_number: 420 },
      { name: "42: Meds & Misc Shoe Needs", order_number: 440 },
      { name: "43: Clothing", order_number: 450 },
      { name: "45: Meds", order_number: 460 },
      { name: "46: Meds", order_number: 470 },
      { name: "Unassigned", order_number: 0 }
    ]

    default_aisles.each do |aisle_attributes|
      user.aisles.find_or_create_by!(aisle_attributes)
      puts '.'
    end

    puts "#{user.aisles.count} aisles for #{user.email}"
  end
end
