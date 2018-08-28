# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Recipe.destroy_all
MealPlan.destroy_all

recipe = Recipe.create!(
  title: 'Sample Recipe',
  source_name: 'RecipeSite',
  source_url: 'http://www.google.com',
  servings: 2,
  prep_time: 10,
  cook_time: 20,
  instructions: "Lorem ipsum dolor sit amet.\n\nConsectetur adipisicing elit, sed do eiusmod tempor incididunt.\n\nUt labore et dolore magna aliqua.\nUt enim ad minim veniam\nExcepteur sint occaecat cupidatat non proident\nSunt in culpa qui officia deserunt mollit anim id est laborum."
)

Ingredient.create!([
  {
    recipe_id: recipe.id,
    quantity: 1,
    measurement_unit: 'T',
    name: 'Paprika',
    preparation_style: 'ground'
  },
  {
    recipe_id: recipe.id,
    quantity: 0.125,
    measurement_unit: 'tsp',
    name: 'Sea Salt',
    preparation_style: ''
  },
  {
    recipe_id: recipe.id,
    quantity: 1,
    measurement_unit: 'cup',
    name: 'Carrot',
    preparation_style: 'sliced'
  },
])

poboy_instructions = [
  "Turn your oven onto broil",
  "Cut your bread into 6″ lengths, then cut it open",
  "Place both side face up on a baking tray and top both pieces of bread with cheese and banana peppers",
  "Broil for just a few minutes while you prep the other vegetables",
  "Thinly slice your cucumbers and bell pepper",
  "Check your bread",
  "Thinly slice your tomatoes and onion",
  "Prep your greens",
  "Check your bread",
  "When the bread and cheese are getting all goldeny and delicious, pull them out",
  "Top with all of your vegetables, then close the lid",
  "Enjoy with a side of chips",
]
poboy = Recipe.create!(
  title: "Veggie Po'boy",
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  instructions: poboy_instructions.join("\n\n")
)

poboy.ingredients.create!([
  {
    quantity: 8,
    measurement_unit: 'slice',
    name: 'Muenster Cheese'
  },
  {
    quantity: 1,
    measurement_unit: 'cup',
    name: 'Cucumber',
    preparation_style: 'sliced'
  },
  {
    quantity: 2,
    measurement_unit: 'whole',
    name: 'Tomato',
    preparation_style: 'sliced'
  },
  {
    quantity: 0.5,
    measurement_unit: 'whole',
    name: 'Red Bell Pepper',
    preparation_style: 'matchsticked'
  },
  {
    quantity: 0.5,
    measurement_unit: 'whole',
    name: 'Green Bell Pepper',
    preparation_style: 'matchsticked'
  },
  {
    quantity: 0.25,
    measurement_unit: 'cup',
    name: 'Pitted Black Olives',
    preparation_style: 'sliced'
  },
  {
    quantity: 3,
    measurement_unit: 'cup',
    name: 'salad greens',
    preparation_style: 'chopped'
  },
  {
    quantity: 4,
    measurement_unit: 'whole',
    name: "Po'Boy rolls",
  },
  {
    quantity: 2,
    measurement_unit: 'tsp',
    name: 'Dried Oregano',
  },
  {
    quantity: 12,
    measurement_unit: 'leaf',
    name: 'Fresh Basil',
    preparation_style: 'chopped'
  }
])

caraotas_instructions = [
  "Add bacon to medium saucepan over medium-high heat.",
  "Cook until fat is rendered and bacon begins to crisp, about 7 minutes.",
  "Add onions, peppers and garlic.",
  "Cook, stirring occasionally, until onions soften and begin to brown, about 12 minutes.",
  "Stir in brown sugar cane (if desired), stirring until well combined.",
  "Stir in black beans, 3/4 cup water and Adobo.",
  "Bring mixture to boil."
]
caraotas = Recipe.create!(
  title: 'Caraotas Negras',
  source_name: 'GOYA',
  source_url: 'https://www.goya.com/en/recipes/dishes-desserts/caraotas-negras',
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  instructions: caraotas_instructions.join("\n\n")
)

caraotas.ingredients.create!([
  {
    quantity: 1,
    measurement_unit: 'whole',
    name: 'Plaintain Maduro',
    preparation_style: 'sliced'
  },
  {
    quantity: 3,
    measurement_unit: 'sprig',
    name: 'Fresh Cilantro',
    preparation_style: 'chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'Adobo Seasoning',
  },
  {
    quantity: 2,
    measurement_unit: 'ounce',
    name: 'Queso Blanco',
    preparation_style: 'crumbled'
  },
  {
    quantity: 2,
    measurement_unit: 'can',
    name: 'Canned Black Beans',
    preparation_style: 'finely chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'Brown Cane Sugar',
    preparation_style: 'grated'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'garlic',
    preparation_style: 'minced'
  },
  {
    quantity: 0.75,
    measurement_unit: 'cup',
    name: 'onion',
    preparation_style: 'finely chopped'
  },
  {
    quantity: 0.25,
    measurement_unit: 'whole',
    name: 'Red Bell Pepper',
    preparation_style: 'finely chopped'
  },
  {
    quantity: 0.25,
    measurement_unit: 'whole',
    name: 'Green Bell Pepper',
    preparation_style: 'finely chopped'
  }
])


pad_thai_instructions = [
  "Cook pasta according to package directions. Toss with 1 teaspoon olive oil.",
  "In a small bowl, whisk soy sauce, peanut butter, sugar, chili flakes, and 1 tablespoon water until smooth. Set aside.",
  "Cook onion and bell peppers",
  "Add in tofu and cook for another 2 minutes.",
  "Add cooked pasta and peanut butter mixture to pan",
  "Add chopped cilantro.",
  "Garnish with crushed peanuts, bean sprouts, or lime wedge if desired.",
]
pad_thai = Recipe.create!(
  title: 'Quick Pad Thai',
  source_name: "Women's Health Magazine",
  source_url: 'https://subscribe.hearstmags.com/circulation/shared/index.html',
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  instructions: pad_thai_instructions.join("\n\n")
)

pad_thai.ingredients.create!([
  {
    quantity: 0.25,
    measurement_unit: 'cup',
    name: 'peanut butter'
  },
  {
    quantity: 0.5,
    measurement_unit: 'cup',
    name: 'red bell pepper',
    preparation_style: 'finely chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'soy sauce'
  },
  {
    quantity: 1,
    measurement_unit: 'tsp',
    name: 'brown sugar'
  },
  {
    quantity: 0.5,
    measurement_unit: 'T',
    name: 'rice vinegar'
  },
  {
    quantity: 8,
    measurement_unit: 'ounce',
    name: 'spaghetti',
    preparation_style: 'cooked'
  },
  {
    quantity: 1,
    measurement_unit: 'tsp',
    name: 'crushed red pepper',
  },
  {
    quantity: 4,
    measurement_unit: 'sprig',
    name: 'fresh cilantro',
    preparation_style: 'chopped'
  }
])


lentil_soup_instructions = [
  "Simmer soup mix and water for 30 minutes.",
  "Add cut-up carrots, celery and onion.",
  "Continue cooking for 30 minutes or until ingredients are soft.",
  "Cool soup enough to blend.",
  "Place soup in blender, and blend until smooth. <-- skip this",
  "Add 1 cup Milk (rice, soy, etc.) to blended soup.",
  "Season to taste and warm soup to serving temperature- but do not boil.",
  "Note, broth can be substituted for water.",
]
lentil_soup = Recipe.create!(
  title: 'Creamy Lentil Soup',
  source_name: "Bob's Red Mill",
  source_url: 'https://www.bobsredmill.com/recipes/how-to-make/creamed-vegi-soup/',
  servings: 4,
  prep_time: 20,
  cook_time: 30,
  instructions: lentil_soup_instructions.join("\n\n")
)

lentil_soup.ingredients.create!([
  {
    quantity: 1,
    measurement_unit: 'can',
    name: 'coconut milk'
  },
  {
    quantity: 3,
    measurement_unit: 'cup',
    name: 'water'
  },
  {
    quantity: 0.333,
    measurement_unit: 'cup',
    name: 'dry red lentils',
    preparation_style: 'sorted'
  },
  {
    quantity: 0.333,
    measurement_unit: 'cup',
    name: 'dry brown lentils',
    preparation_style: 'sorted'
  },
  {
    quantity: 0.25,
    measurement_unit: 'cup',
    name: 'yellow lentils',
    preparation_style: 'sorted'
  },
  {
    quantity: 0.125,
    measurement_unit: 'cup',
    name: 'couscous',
    preparation_style: 'uncooked'
  },
  {
    quantity: 2,
    measurement_unit: 'leaf',
    name: 'bay leaf'
  },
  {
    quantity: 0.5,
    measurement_unit: 'tsp',
    name: 'sea salt',
  },
  {
    quantity: 2,
    measurement_unit: 'stalk',
    name: 'celery',
    preparation_style: 'finely chopped'
  },
  {
    quantity: 2,
    measurement_unit: 'whole',
    name: 'carrot',
    preparation_style: 'finely chopped'
  }
])


5.times do
  MealPlan.create!(
    start_date: rand((Date.today - 100)...Date.today),
    people_served: 2,
    recipes: Recipe.all.sample(rand(2..5))
  )
end
