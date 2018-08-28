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
