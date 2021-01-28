# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Recipe.destroy_all
MealPlan.destroy_all
User.destroy_all

admin_user = User.create!({
  email: 'admin@email.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
})

User.create!({
  email: 'user2@email.com',
  password: 'password',
  password_confirmation: 'password'
})

recipe = Recipe.create!(
  user_id: admin_user.id,
  title: 'Sample Recipe',
  source_name: 'RecipeSite',
  source_url: 'http://www.google.com',
  servings: 2,
  prep_time: 10,
  cook_time: 20,
  reheat_time: 20,
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
  user_id: admin_user.id,
  title: "Veggie Po'boy",
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  reheat_time: 20,
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
  user_id: admin_user.id,
  title: 'Caraotas Negras',
  source_name: 'GOYA',
  source_url: 'https://www.goya.com/en/recipes/dishes-desserts/caraotas-negras',
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  reheat_time: 10,
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
  user_id: admin_user.id,
  title: 'Quick Pad Thai',
  source_name: "Women's Health Magazine",
  source_url: 'https://subscribe.hearstmags.com/circulation/shared/index.html',
  servings: 4,
  prep_time: 10,
  cook_time: 20,
  reheat_time: 10,
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
  user_id: admin_user.id,
  title: 'Creamy Lentil Soup',
  source_name: "Bob's Red Mill",
  source_url: 'https://www.bobsredmill.com/recipes/how-to-make/creamed-vegi-soup/',
  servings: 4,
  prep_time: 20,
  cook_time: 30,
  reheat_time: 10,
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

blended_lentils = Recipe.create!(
  user_id: admin_user.id,
  title: 'Blended Red Lentil Soup',
  source_name: 'Loving it Vegan',
  source_url: 'https://lovingitvegan.com/vegan-lentil-soup/',
  servings: 4,
  prep_time: 10,
  cook_time: 30,
  reheat_time: 10,
  instructions: [
    "Peel and chop the onion and add to a pot with the olive oil and cumin and sauté until slightly softened.",
    "Add the carrots and toss together. Then the lentils and toss together with the other vegetables.",
    "Finally, add in the vegetable stock and mix together.",
    "Bring to the boil and then reduce heat, cover the pot and simmer until the lentils are cooked (they should be soft).",
    "Take the pot off the heat and blend directly in the pot using an immersion blender.",
    "If you don’t have an immersion blender, then transfer to your blender jug and blend up in stages until it’s all smooth.",
    "Serve into bowls and garnish with black pepper."
  ].join("\n\n")
)

blended_lentils.ingredients.create!([
  {
    quantity: 1,
    measurement_unit: 'cup',
    name: 'onion',
    preparation_style: 'chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'olive oil'
  },
  {
    quantity: 1,
    measurement_unit: 'tsp',
    name: 'cumin',
    preparation_style: 'ground'
  },
  {
    quantity: 2,
    measurement_unit: 'whole',
    name: 'carrot',
    preparation_style: 'chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'cup',
    name: 'dry red lentils',
    preparation_style: 'sorted'
  },
  {
    quantity: 4,
    measurement_unit: 'cup',
    name: 'vegetable stock',
  },
  {
    quantity: 1,
    measurement_unit: 'loaf',
    name: 'crusty bread',
    preparation_style: 'sliced'
  }
])


quiche = Recipe.create!(
  user_id: admin_user.id,
  title: 'Quiche',
  servings: 4,
  prep_time: 10,
  cook_time: 30,
  reheat_time: 20,
  instructions: [
    "Preheat oven 350F (or just use a toaster oven so you don't have to preheat)",
    "Prebake the crust for about 10 mi. Keep an eye on it because you don't want it to get too deformed in the process.",
    "You don't have to prebake, but it keeps the bottom of the crust from getting mushy from the eggs.",
    "While the crust is prebaking, prepare your tomato and spinach",
    "When the crust is done, whisk the eggs and herbs/spices thoroughly",
    "Mix in the feta, tomato, and spinach",
    "Pour into shell",
    "Bake about 45 min"
  ].join("\n\n")
)

quiche.ingredients.create!([
  {
    quantity: 1,
    measurement_unit: 'whole',
    name: 'pie crust'
  },
  {
    quantity: 1,
    measurement_unit: 'whole',
    name: 'tomato',
    preparation_style: 'diced'
  },
  {
    quantity: 6,
    measurement_unit: 'ounce',
    name: 'frozen chopped spinach',
    preparation_style: 'thawed'
  },
  {
    quantity: 0.5,
    measurement_unit: 'dozen',
    name: 'egg'
  },
  {
    quantity: 0.25,
    measurement_unit: 'cup',
    name: 'feta',
    preparation_style: 'crumbled'
  },
  {
    quantity: 0.125,
    measurement_unit: 'tsp',
    name: 'garlic powder'
  },
  {
    quantity: 0.125,
    measurement_unit: 'tsp',
    name: 'onion powder'
  },
  {
    quantity: 0.5,
    measurement_unit: 'tsp',
    name: 'basil',
    preparation_style: 'dried'
  },
  {
    quantity: 0.5,
    measurement_unit: 'tsp',
    name: 'oregano',
    preparation_style: 'dried'
  },
  {
    quantity: 0.125,
    measurement_unit: 'tsp',
    name: 'sea salt'
  }
])


red_lentil_curry = Recipe.create!(
  user_id: admin_user.id,
  title: 'Red Lentil Curry',
  source_name: 'Jessica in the Kitchen',
  source_url: 'https://jessicainthekitchen.com/red-lentil-curry-vegan/',
  servings: 4,
  prep_time: 20,
  cook_time: 30,
  reheat_time: 20,
  instructions: [
    "Cook down the onions and tomatoes",
    "Add in the spices, simmer for about 30 seconds",
    "Add in the lentils & water and bring to a boil.",
    "Be careful to stir enough to keep the lentils from sticking to the bottom.",
    "Bring the temp down and a simmer for 30 min.",
    "Make rice.",
    "When the lentils are soft, turn off the heat and add in the coconut milk."
  ].join("\n\n")
)

red_lentil_curry.ingredients.create!([
  {
    quantity: 2,
    measurement_unit: 'cup',
    name: 'onion',
    preparation_style: 'chopped'
  },
  {
    quantity: 2,
    measurement_unit: 'cup',
    name: 'tomato',
    preparation_style: 'diced'
  },
  {
    quantity: 0.25,
    measurement_unit: 'tsp',
    name: 'garlic powder'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'fresh ginger root',
    preparation_style: 'minced'
  },
  {
    quantity: 0.5,
    measurement_unit: 'tsp',
    name: 'garam masala'
  },
  {
    quantity: 0.75,
    measurement_unit: 'tsp',
    name: 'curry powder'
  },
  {
    quantity: 0.25,
    measurement_unit: 'tsp',
    name: 'cumin',
    preparation_style: 'ground'
  },
  {
    quantity: 1,
    measurement_unit: 'T',
    name: 'red curry paste'
  },
  {
    quantity: 1,
    measurement_unit: 'cup',
    name: 'dry red lentils',
    preparation_style: 'sorted'
  },
  {
    quantity: 2,
    measurement_unit: 'cup',
    name: 'water'
  },
  {
    quantity: 1,
    measurement_unit: 'can',
    name: 'coconut milk'
  },
  {
    quantity: 0.5,
    measurement_unit: 'cup',
    name: 'rice',
    preparation_style: 'uncooked'
  }
])


gnocchi = Recipe.create!(
  user_id: admin_user.id,
  title: 'Creamy Cherry Tomato & Summer Squash Gnocchi',
  source_name: 'Cookie + Kate',
  source_url: 'http://cookieandkate.com/2015/creamy-cherry-tomato-summer-squash-pasta/',
  servings: 4,
  prep_time: 10,
  cook_time: 30,
  reheat_time: 30,
  instructions: [
    "When Preparing in Advance",
    "Divide all of the veg into 2 containers.",
    "Cook the gnocchi when you plan to eat it, not in advance",
    "Use 8oz of a 16oz package for each 2-person meal",
    "General Prep Notes",
    "Preheat oven to 400F",
    "Slice the squashes and zucchini into half moons that are about 1/8 inch thick",
    "Lube up the baking tray",
    "Place the squashes and zucchini and whole cherry tomatoes on the baking tray in a single layer",
    "Sprinkle with salt and pepper",
    "Roast for about 25 minutes, stirring to keep from sticking",
    "It's done when the cherry tomatoes have burst and the squash is tender.",
    "Cook the pasta (Use the large soup pot because we're going to put the pasta back in it) NOTE: Don't drain the pasta without consulting the next step.",
    "Set aside about a cup of pasta water when you strain the pasta.",
    "Add 2 TBSP oil to the bottom of the soup pot then put the pasta back in and stir.",
    "Immediately add the goat cheese, garlic, and red pepper flakes",
    "Put the small mesh strainer over the pot and juice the lemon into the mix. (you may have to put one end of the strainer on the pot and the other on a wooden spoon across the pot)",
    "Add about 1/4 cup of the reserved pasta cooking water and gently toss the pasta until the ingredients are evenly mixed together and the pasta is coated in a light sauce (add more reserved cooking water if the pasta seems dry).",
    "Once the tomatoes and squash are done, pour the whole thing into the pot, jusices and all",
    "Season to taste with salt and pepper",
    "Stir in the basil and oregano"
  ].join("\n\n")
)

gnocchi.ingredients.create!([
  {
    quantity: 16,
    measurement_unit: 'ounce',
    name: 'gnocchi',
    preparation_style: 'uncooked'
  },
  {
    quantity: 1,
    measurement_unit: 'pint',
    name: 'cherry tomato',
    preparation_style: 'sliced in half'
  },
  {
    quantity: 2,
    measurement_unit: 'whole',
    name: 'yellow squash',
    preparation_style: 'sliced'
  },
  {
    quantity: 1,
    measurement_unit: 'whole',
    name: 'zucchini',
    preparation_style: 'sliced'
  },
  {
    quantity: 2,
    measurement_unit: 'T',
    name: 'olive oil'
  },
  {
    quantity: 2,
    measurement_unit: 'T',
    name: 'lemon juice'
  },
  {
    quantity: 1,
    measurement_unit: 'ounce',
    name: 'goat cheese',
    preparation_style: 'crumbled'
  },
  {
    quantity: 0.125,
    measurement_unit: 'tsp',
    name: 'garlic powder'
  },
  {
    quantity: 0.5,
    measurement_unit: 'tsp',
    name: 'crushed red pepper flakes'
  },
  {
    quantity: 8,
    measurement_unit: 'leaf',
    name: 'fresh basil',
    preparation_style: 'chopped'
  },
  {
    quantity: 1,
    measurement_unit: 'tsp',
    name: 'oregano',
    preparation_style: 'dried'
  }
])


5.times do
  MealPlan.create!(
    prepared_on: rand((Time.zone.today - 100)...Time.zone.today),
    people_served: 2,
    recipes: Recipe.all.sample(rand(2..5))
  )
end
