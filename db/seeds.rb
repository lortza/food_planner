MealPlanRecipe.destroy_all
Recipe.destroy_all
MealPlan.destroy_all
Ingredient.destroy_all
Aisle.destroy_all
User.destroy_all

user = User.create!(
  {email: 'admin@email.com', password: 'password', password_confirmation: 'password', admin: true }
)

recipe_49 = Recipe.create!(
  { user_id: user.id, title: "Veggie Po'boy", source_name: 'Warm Kitchen', source_url: "https://warmkitchen.wordpress.com/2014/11/12/its-a-veggie-po-boy-yall/", servings: 4, instructions: "Turn your oven onto broil\r\n\r\nCut your bread into 6″ lengths, then cut it open\r\n\r\nPlace both side face up on a baking tray and top both pieces of bread with cheese and banana peppers\r\n\r\nBroil for just a few minutes while you prep the other vegetables\r\n\r\nThinly slice your cucumbers and bell pepper\r\n\r\nCheck your poboy bread\r\n\r\nThinly slice your tomatoes and onion\r\n\r\nPrep your greens\r\n\r\nCheck your bread\r\n\r\nWhen the bread and cheese are getting all goldeny and delicious, pull them out\r\n\r\nTop with all of your vegetables, then close the lid\r\n\r\nEnjoy with a side of chips", prep_time: 10, cook_time: 20, image_url: "http://cdn2.pepperplate.com/recipes/bcb751ba9ab749dbb0f48ffb083a72c5.jpg", reheat_time: 20, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=15454393", notes: '', archived: false }
)
recipe_51 = Recipe.create!(
  { user_id: user.id, title: "Quick Pad Thai", source_name: "Women's Health Magazine", source_url: "https://subscribe.hearstmags.com/circulation/shared/index.html", servings: 4, instructions: "Cook pasta according to package directions. Toss with 1 teaspoon olive oil.\r\n\r\nIn a small bowl, whisk soy sauce, peanut butter, sugar, chili flakes, and 1 tablespoon water until smooth. Set aside.\r\n\r\nCook onion and bell peppers\r\n\r\nAdd in tofu and cook for another 2 minutes.\r\n\r\nAdd cooked pasta and peanut butter mixture to pan\r\n\r\nAdd chopped cilantro.\r\n\r\nGarnish with crushed peanuts, bean sprouts, or lime wedge if desired.", prep_time: 10, cook_time: 20, image_url: "http://cdn2.pepperplate.com/recipes/dad9e72fa23f4e839c6057b8684da88e.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=15772038", notes: '', archived: false }
)
recipe_54 = Recipe.create!(
  { user_id: user.id, title: "Quiche", source_name: 'Original Creation', source_url: "/", servings: 4, instructions: "Preheat oven 350F (or just use a toaster oven so you don't have to preheat)\r\n\r\nPrebake the crust for about 10 mi. Keep an eye on it because you don't want it to get too deformed in the process.\r\n\r\nYou don't have to prebake, but it keeps the bottom of the crust from getting mushy from the eggs.\r\n\r\nWhile the crust is prebaking, prepare your tomato and spinach\r\n\r\nWhen the crust is done, whisk the eggs and herbs/spices thoroughly\r\n\r\nMix in the feta, tomato, and spinach\r\n\r\nPour into shell\r\n\r\nBake about 45 min", prep_time: 10, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/07aae73855464443b20e789a31df8caf.jpg", reheat_time: 20, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=19998600", notes: '', archived: false }
)
recipe_52 = Recipe.create!(
  { user_id: user.id, title: "Creamy Lentil Soup", source_name: "Bob's Red Mill", source_url: "https://www.bobsredmill.com/recipes/how-to-make/creamed-vegi-soup/", servings: 4, instructions: "Simmer soup mix and water for 30 minutes.\r\n\r\nAdd cut-up carrots, celery and onion.\r\n\r\nContinue cooking for 30 minutes or until ingredients are soft.\r\n\r\nCool soup enough to blend.\r\n\r\nPlace soup in blender, and blend until smooth. <-- skip this\r\n\r\nAdd 1 cup Milk (rice, soy, etc.) to blended soup.\r\n\r\nSeason to taste and warm soup to serving temperature- but do not boil.\r\n\r\nNote, broth can be substituted for water.", prep_time: 20, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/66a034972ccf478c98983f876d11de6b.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=18529284", notes: '', archived: false }
)
recipe_55 = Recipe.create!(
  { user_id: user.id, title: "Red Lentil Curry", source_name: "Jessica in the Kitchen", source_url: "https://jessicainthekitchen.com/red-lentil-curry-vegan/", servings: 4, instructions: "Cook down the onions and tomatoes\r\n\r\nAdd in the spices, simmer for about 30 seconds\r\n\r\nAdd in the lentils & water and bring to a boil.\r\n\r\nBe careful to stir enough to keep the lentils from sticking to the bottom.\r\n\r\nBring the temp down and a simmer for 30 min.\r\n\r\nMake rice.\r\n\r\nWhen the lentils are soft, turn off the heat and add in the coconut milk.", prep_time: 20, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/5b8972b2e1344a83965f7a248ec4f978.jpg", reheat_time: 15, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22761475", notes: '', archived: false }
)
recipe_53 = Recipe.create!(
  { user_id: user.id, title: "Blended Red Lentil Soup", source_name: "Loving it Vegan", source_url: "https://lovingitvegan.com/vegan-lentil-soup/", servings: 4, instructions: "Peel and chop the onion and add to a pot with the olive oil and cumin and sauté until slightly softened.\r\n\r\nAdd the carrots and toss together. Then the lentils and toss together with the other vegetables.\r\n\r\nFinally, add in the vegetable stock and mix together.\r\n\r\nBring to the boil and then reduce heat, cover the pot and simmer until the lentils are cooked (they should be soft).\r\n\r\nTake the pot off the heat and blend directly in the pot using an immersion blender.\r\n\r\nIf you don’t have an immersion blender, then transfer to your blender jug and blend up in stages until it’s all smooth.\r\n\r\nServe into bowls and garnish with black pepper.", prep_time: 10, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/7830f70754dd4f75ba89595ee1568cf2.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22709198", notes: '', archived: false }
)
recipe_50 = Recipe.create!(
  { user_id: user.id, title: "Caraotas Negras", source_name: "GOYA", source_url: "https://www.goya.com/en/recipes/dishes-desserts/caraotas-negras", servings: 4, instructions: "Add bacon to medium saucepan over medium-high heat.\r\n\r\nCook until fat is rendered and bacon begins to crisp, about 7 minutes.\r\n\r\nAdd onions, peppers and garlic.\r\n\r\nCook, stirring occasionally, until onions soften and begin to brown, about 12 minutes.\r\n\r\nStir in brown sugar cane (if desired), stirring until well combined.\r\n\r\nStir in black beans, 3/4 cup water and Adobo.\r\n\r\nBring mixture to boil.", prep_time: 10, cook_time: 20, image_url: "http://cdn2.pepperplate.com/recipes/edca0cc48bfe4d45bf3d27bb66b76c3b.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=20213928", notes: '', archived: false }
)
recipe_64 = Recipe.create!(
  { user_id: user.id, title: "Arroz Con Gandules Pigeon Peas", source_name: "GOYA", source_url: "https://www.goya.com/en/recipes/arroz-con-gandules", servings: 8, instructions: "Toast coconut flakes in a dry skillet until they start to get a little brown\r\n\r\nIn large skillet, cook onions and peppers, cook for 3 minutes\r\n\r\nStir in garlic\r\n\r\nAdd gandules, tomato sauce, water, and bring to a boil\r\n\r\nAdd coconut flakes and rice\r\n\r\nStir, cover, reduce to simmer for 25 min", prep_time: 10, cook_time: 25, image_url: "http://cdn2.pepperplate.com/recipes/597c21cde8f243d8963affe31aa588b6.jpg", reheat_time: 15, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=20213636", notes: '', archived: false }
)
recipe_67 = Recipe.create!(
  { user_id: user.id, title: "Asian Raw Kale Salad", source_name: "Cookie + Kate", source_url: "https://cookieandkate.com/2011/raw-kale-asian-salad/", servings: 4, instructions: "First you have to make the dressing. Simply blend all dressing ingredients thoroughly in a food processor or blender.\r\n\r\nPull the kale leaves off from the tough stem, and break into small, bite sized pieces. \r\n\r\nSprinkle with sea salt and massage the leaves for a couple of minutes, meaning that you should scrunch handfuls of kale in your hands, release, repeat. The kale will become darker in color and more fragrant. This step improves the taste of raw kale.\r\n\r\nThrow the kale into a bowl, drizzle in the salad dressing (don’t skimp), and toss thoroughly.\r\n\r\nAdd the avocado, carrots, cabbage and red onion.\r\n\r\nTop with cilantro and a big sprinkle of sesame seeds. Enjoy!", prep_time: 60, cook_time: 0, image_url: "http://cdn2.pepperplate.com/recipes/eebd1e4d5b7e4a4b8e143c745ac5e180.jpg", reheat_time: 0, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=20582867", notes: '', archived: false }
)
recipe_73 = Recipe.create!(
  { user_id: user.id, title: "Potato Leek Soup", source_name: "Bon Appétit", source_url: "https://www.bonappetit.com/recipe/potato-leek-soup-toasted-nuts-seeds", servings: 6, instructions: "Trim dark green leaves from leeks; discard all but 2. Tuck thyme, rosemary, and bay leaves inside leek leaves; tie closed with kitchen twine. Thinly slice light and pale-green parts of leeks.\r\n\r\nHeat butter in a large heavy pot over medium-high. Add celery and sliced leeks and season with salt and pepper. Cook, stirring, until leeks begin to soften, about 5 minutes. Reduce heat to medium-low, add herb bundle, cover pot, and cook, checking and stirring occasionally, until leeks and celery are very soft, 25–30 minutes (this long, slow cooking draws maximum flavor out of the vegetables). Increase heat to medium-high, add potato and 5 cups broth, and bring to a boil. Reduce heat and simmer, stirring occasionally, until potato is very tender, 10–15 minutes. Let cool slightly.\r\n\r\nWorking in batches, purée leek mixture in a blender until very smooth (make sure lid is slightly ajar to let steam escape; cover with a towel). Transfer to a large bowl or pitcher.\r\nPour soup back into pot and add cream. Thin with broth, if needed. Taste and season with salt and pepper; keep warm.\r\n\r\nHeat oil in a small skillet over medium. Add almonds, sunflower seeds, and coriander seeds and sprinkle sugar over; cook, stirring, until nuts and seeds are golden, about 4 minutes. Transfer nuts to paper towels to drain; season with salt and pepper.\r\n\r\nServe soup topped with crème fraîche and nut mixture.\r\n\r\nDo ahead: Soup and nut mixture can be made 4 days ahead. Let soup cool; cover and chill. Store nut mixture airtight at room temperature.", prep_time: 60, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/8e88c9c12e3c4ffc93084d97ba476877.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22778959", notes: '', archived: false }
)
recipe_83 = Recipe.create!(
  { user_id: user.id, title: "Lentil & Kale Egg Noodle Bowl", source_name: "Clean and Delicious", source_url: "https://cleananddelicious.com/2017/10/06/lentil-kale-whole-grain-noodle-bowl/", servings: 4, instructions: "Heat olive oil in a large sauce pan before adding in onion. Cook for about 5 minutes or until the onions are tender and translucent.\r\n\r\nAdd in garlic, cumin and lentils. Gently mix together and season with salt and pepper. Next, add the veggie broth and let everything simmer until heated through.\r\n\r\nIn the meantime, cook your noodles according to the package directions and drain.\r\n\r\nPlace kale on the bottom of the pot and then pour hot noodles over the kale. Top with the lentil mixture and mix everything together. Finish with parmesan cheese and enjoy!", prep_time: 5, cook_time: 20, image_url: "http://cdn2.pepperplate.com/recipes/35d6e74b67b74514954b65988119b7c9.jpg", reheat_time: 5, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22997172", notes: '', archived: false }
)
recipe_70 = Recipe.create!(
  { user_id: user.id, title: "Pierogi Pizza", source_name: "All Recipes", source_url: "https://www.allrecipes.com/recipe/245593/pierogi-pizza/", servings: 4, instructions: "Place potatoes in a large pot and pour in enough water to cover. Add bouillon. Bring to a boil; cook until potatoes are just tender, about 10 minutes. Drain.\r\n\r\nHeat 2 tablespoons olive oil in a large skillet over medium-high heat; add potatoes and cook until lightly golden, about 5 minutes.\r\n\r\nPreheat oven to 400 degrees F (200 degrees C).\r\n\r\nWhisk sour cream and granulated garlic together in a small bowl to make pizza \"sauce\".\r\n\r\nGently pat and stretch pizza dough out to a 12-inch circle on a pizza stone. Spread sauce evenly over dough. Layer potatoes on top to cover dough completely. Sprinkle Cheddar cheese, green onions, and bacon bits on top.\r\n\r\nBake pizza in the preheated oven until crust is golden brown, 15 to 20 minutes.", prep_time: 60, cook_time: 30, image_url: "https://images.media-allrecipes.com/userphotos/560x315/3383420.jpg", reheat_time: 20, pepperplate_url: nil, notes: nil, archived: false }
)
recipe_71 = Recipe.create!(
  { user_id: user.id, title: "Sweet Potato Gnocchis", source_name: 'Original Creation', source_url: "/", servings: 4, instructions: "Boil water in a medium sauce pan\r\n\r\nPrepare spices and chop the broccolini\r\n\r\nWhen the water is boiling, drop in the gnocchi. Boil until they float and then drain immediately.\r\n\r\nMeanwhile, start melting butter in a skillet. When the gnocchis are sufficiently drained, add them plus the broccolini and spices to the skillet. \r\n\r\nCook just enough to brown everything a little bit. \r\n\r\nRemove from skillet and mix in with a little goat cheese until well combined. Serve immediately. ", prep_time: 10, cook_time: 20, image_url: '', reheat_time: 20, pepperplate_url: nil, notes: nil, archived: false }
)
recipe_72 = Recipe.create!(
  { user_id: user.id, title: "Corn Chowder", source_name: "I Eat Green", source_url: "http://www.ieatgreen.com/vegan-corn-chowder/", servings: 6, instructions: "Sautee the onion in the pot with the lid on\r\n\r\nAdd the rest of the veg and spices and close the lid. Cook down for about 15 minutes.\r\n\r\nAdd the vegetable stock and simmer on low for 20 min.\r\n\r\nRemove from heat. Add the can of coconut milk and parsley to the pot.\r\n\r\nBlend with the immersion blender, until chunky.", prep_time: 15, cook_time: 30, image_url: "http://www.ieatgreen.com/wp-content/uploads/2012/08/IMG_0422-1024x941.jpg", reheat_time: 15, pepperplate_url: nil, notes: nil, archived: false }
)
recipe_69 = Recipe.create!(
  { user_id: user.id, title: "City O City Breakfast Burrito", source_name: 'Original Creation', source_url: "/", servings: 6, instructions: "Cube and bake the potato\r\n\r\nChop and sautee: onion, bell pepper, anaheim\r\n\r\nOnce softened, mix in crumbled tofu and add spices\r\n\r\nWhen potatoes are done, mix them into the tofu\r\n\r\nUse the Toaster oven to soften the large tortillas\r\n\r\nPut each one on a plate, fill with mixture and fixins.\r\n\r\nRoll & top with salsa.", prep_time: 20, cook_time: 5, image_url: "http://cdn2.pepperplate.com/recipes/49fb0f90f37f4c5190840f7565b6d821.jpg", reheat_time: 20, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=19268430", notes: '', archived: false }
)
recipe_77 = Recipe.create!(
  { user_id: user.id, title: "Curried Satay Veggie Bowls", source_name: "Jessica In the Kitchen", source_url: "https://jessicainthekitchen.com/curried-satay-veggie-bowls/", servings: 4, instructions: "Weekly meal prep notes\r\nSpiralize or peel the zucchini into ribbons. Cook them briefly in a little oil to soften.\r\nCook the spaghetti.\r\nSet aside the zucchini and spaghetti.\r\nPlace everything else in a quart mason jar\r\nBlend with the immersion blender\r\nAdd water until it is a saucy consistency\r\nStore the sauce in the same jar that you blended it in. Plan to use 1/2 of it for (2 servings) at a time.\r\nStore the zucchini, sauce, and cooked spaghetti separately.\r\n\r\nWhen reheating\r\nWarm the pasta with warm water\r\nWarm the sauce and zucchini in a pot\r\nMix in the pasta before serving", prep_time: 20, cook_time: 10, image_url: "http://cdn2.pepperplate.com/recipes/b734213a02984cbb83a471eca370fd45.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22657139", notes: '', archived: false }
)
recipe_76 = Recipe.create!(
  { user_id: user.id, title: "Wild Rice and Mushroom Soup", source_name: "Pinch of Yum", source_url: "https://pinchofyum.com/instant-pot-wild-rice-soup", servings: 6, instructions: "Stovetop: When the soup is done, melt the butter in a saucepan. Whisk in the flour. Let the mixture cook for a minute or two to remove the floury taste. Whisk the milk, a little bit at a time, until you have a smooth, thickened sauce. Throw a little salt in there for good measure.\r\n", prep_time: 20, cook_time: 60, image_url: "http://cdn2.pepperplate.com/recipes/f758b85c4a374355a63df720998097d2.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=23158236", notes: '', archived: false }
)
recipe_75 = Recipe.create!(
  { user_id: user.id, title: "Jackfruit Melt Sandwich", source_name: "Keepin It Kind", source_url: "http://keepinitkind.com/jackfruit-tuna-melt-sandwich/", servings: 6, instructions: "Sautee onion & garlic\r\n\r\nAdd tarragon, jackfruit, and beans to warm\r\n\r\nOnce warmed, pour mixture into a bowl\r\n\r\nMix with mayo, celery, mustard, relish, lemon juice, and mash it up together. Mashing the beans is nice, but don't expect to mash them completely.\r\n\r\nLightly pre-toast the bread\r\n\r\nWhen done, put a slice of cheese on each face and toast it enough to melt it and harden the bread slightly\r\n\r\nSpoon some jackfruit mix onto a slice of bread, top with tomato & greens, put the other slice on and cut in half.\r\n\r\nDelicious hot or cold.", prep_time: 15, cook_time: 10, image_url: "http://cdn2.pepperplate.com/recipes/47b2f69c8d0d43dda4afe9d63f442a3f.jpg", reheat_time: 15, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=19099296", notes: '', archived: false }
)
recipe_78 = Recipe.create!(
  { user_id: user.id, title: "Tortilla Soup", source_name: "Cookie + Kate", source_url: "https://cookieandkate.com/2013/vegetarian-tortilla-soup/", servings: 6, instructions: "Prep work: Preheat the oven to 475 degrees Fahrenheit. Stack the tortillas and slice them into 1/2-inch-wide, 2-inch-long strips. Remove the seeds and membranes from the jalapeno (and poblano, if using) and chop the peppers. Wash your hands. Pit, peel, and medium dice the avocado, then squeeze some lime juice over the avocado to prevent browning.\r\n\r\nBake the tortillas: Coat a baking sheet with a thin layer of oil. Toss the tortilla strips in the oil to coat and arrange the strips in a single layer. Bake 6 to 8 minutes, or until golden brown. While the strips are hot, season them with salt.\r\n\r\nToast the chili pepper: Place the dried chili pepper onto a baking sheet and bake for about 1 minute, or until the pepper is warmed through. When cool enough to handle, cut the pepper open and remove the seeds. (Wash your hands afterward and avoid touching your eyes!)\r\n\r\nMake the soup: In a medium pot or Dutch oven, heat some olive oil on medium until hot. Add the onion, garlic, jalapeno and poblano peppers (if using). Cook 4 to 5 minutes, or until softened, stirring occasionally. Stir in the cumin, then the canned tomatoes and vegetable stock. Simmer for about 3 minutes, then add the hominy, black beans and the seeded chili pepper. Cook for 8 to 10 minutes, or until slightly thickened, stirring occasionally. Season with salt and pepper to taste.\r\n\r\nServe the soup: First, discard the dried chili pepper. Place some of the avocado, radishes, tortilla strips, and queso fresco (or feta) at the bottom of 2 to 4 bowls. Divide the soup between the bowls. Top the soup with the remaining avocado, radishes, tortilla strips, and queso fresco (or feta). Garnish with some cilantro and serve with lime wedges and hot sauce, if desired.\r\n", prep_time: 15, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/5fce923917ca4cc684742e986d778104.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22025023", notes: '', archived: false }
)
recipe_81 = Recipe.create!(
  { user_id: user.id, title: "Ginger Broccolini Stir Fry", source_name: "All Recipes", source_url: "http://allrecipes.com/recipe/24712/ginger-veggie-stir-fry/", servings: 4, instructions: "Put 2 cups water in a pot, add 1 cup dry rice. Turn burner on high. Bring to boil and then move to new burner on low.\r\n\r\nprepare stir fry to store for the week\r\nchop all of the things and divide them equally between 2 yogurt containers\r\nmake the rice and divide it between 2 containers\r\n\r\nmake stir fry to eat now\r\nreheat the rice somehow. your choice.\r\nadd a little oil to a skillet\r\ndump 1 of the yogurt containers in the skillet, turn burner to level 8\r\nadd the sauce ingredients, stir & cover\r\nonly let this cook for a few minutes. watch it carefully (with the lid on). You want the veg to soften slightly while still being crispy-ish.\r\nserve over rice.", prep_time: 20, cook_time: 10, image_url: '', reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=18986094", notes: '', archived: false }
)
recipe_80 = Recipe.create!(
  { user_id: user.id, title: "Spicy Black Bean Soup", source_name: "Cookie + Kate", source_url: "https://cookieandkate.com/2016/spicy-vegan-black-bean-soup/", servings: 4, instructions: "Cook down the onions, celery and carrot until soft, about 10 to 15 minutes.\r\n\r\nAdd in spices and stir for 30 seconds\r\n\r\nPour in the beans and broth and bring to a gentle simmer.\r\n\r\nSimmer until the broth is flavorful and the beans are very tender, about 30 minutes.\r\n\r\nTake it off the heat and use the immersion blender + water to your liking to get it your preferred consistency.", prep_time: 20, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/9380a9a30a0e47cfa4bb65f61b9c3834.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22230216", notes: '', archived: false }
)
recipe_82 = Recipe.create!(
  { user_id: user.id, title: "Chorizo Sweet Potato Skillet", source_name: "Budget Bytes", source_url: "http://www.budgetbytes.com/2014/06/chorizo-sweet-potato-skillet/", servings: 6, instructions: "Peel and dice the sweet potato into 1/2 to 3/4 inch cubes (size matters, make them small). Sauté the sweet potato cubes in a large skillet with olive oil over medium heat for about 5 minutes, or until the sweet potatoes have softened about half way through (they'll cook more later).\r\n\r\nSqueeze the chorizo out of its casing into the skillet with the sweet potatoes. Sauté the chorizo and sweet potatoes together, breaking the chorizo up into small pieces as it browns.\r\n\r\nOnce the chorizo is fully browned, pour off any excess grease if needed. Rinse and drain the black beans. Add the beans, salsa, and uncooked rice to the skillet. Stir them into the sweet potatoes and chorizo until everything is well combined.\r\n\r\nAdd the chicken broth, stir briefly, then place a lid on the skillet. Allow the contents of the skillet to come up to a boil, then turn the heat down to low. Let the skillet simmer on low for 30 minutes. Make sure it is simmering the whole time (you should be able to hear it quietly simmer away). If it is not, turn the heat up slightly.\r\n\r\nAfter 30 minutes the rice should be tender and have absorbed all of the liquid. Turn off the heat, fluff the mixture, sprinkle the cheese on top, then return the lid to trap the residual heat and help the cheese melt. Slice the green onions while the cheese is melting, then sprinkle them on top and serve.\r\n", prep_time: 10, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/da3e6c1a7731400dbddfba8d6c9f9413.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=15454413", notes: '', archived: false }
)
recipe_85 = Recipe.create!(
  { user_id: user.id, title: "Sweet Potato Pie", source_name: "ThroughmyiMedia", source_url: "https://youtu.be/BOYWrXVGV5E?t=148", servings: 8, instructions: "Heat oven to 350F\r\n\r\nWash sweet potatoes and poke holes in them with a fork\r\n\r\nRub them in butter and wrap them in foil.\r\n\r\nBake for an hour or until they are soft. Cool them for 20 minutes before peeling. \r\n\r\nPre-bake empty pie shell for 15-20 minutes until dough starts to brown. Remember to cover the edges with foil so they don't brown too fast. \r\n\r\nMash them in a bowl with all of the dry ingredients.\r\n\r\nBeat eggs and add to the potato mix. Incorporate completely. \r\n\r\nAdd butter and milk and mix on slow speed until well incorporated.\r\n\r\nPour mixture into pie shell and bake at 350F for 45 minutes until the pie has set and the crust edges are golden brown.\r\n", prep_time: 0, cook_time: 0, image_url: '', reheat_time: 0, pepperplate_url: '', notes: '', archived: false }
)
recipe_86 = Recipe.create!(
  { user_id: user.id, title: "test recipe", source_name: 'Original Creation', source_url: "/", servings: 4, instructions: "Boil the water\r\n\r\nCool the water", prep_time: 30, cook_time: 30, image_url: "http://i.dailymail.co.uk/i/pix/2015/05/22/13/28F805FD00000578-0-image-a-36_1432299542585.jpg", reheat_time: 15, pepperplate_url: '', notes: '', archived: false }
)
recipe_87 = Recipe.create!(
  { user_id: user.id, title: "Twice-Baked Sweet Potatoes", source_name: "Rachael Ray", source_url: "https://www.rachaelrayshow.com/recipe/15311_Twice_Baked_Sweet_Potatoes", servings: 4, instructions: "Preheat oven to 350F.\r\n\r\nPlace the potatoes on a small baking sheet. Drizzle with a little EVOO and rub them with some salt and freshly ground black pepper. Bake them 45 minutes to an hour, until tender. When the potatoes have finished baking, remove them from the oven and allow them to cool enough that you can handle them.\r\n\r\nWhile the potatoes are cooling, heat a small skillet over medium heat and saut the chorizo until crisp, 4-5 minutes. Remove the cooked chorizo from the pan to a paper towel-lined plate and reserve. Preheat broiler to high.\r\n\r\nWhen youre able to handle the potatoes, cut them lengthwise, being careful not to cut them all the way through (you should be able to open the potato like a book). Scoop out the cooked insides using a spoon, then transfer them to the same pan you cooked the chorizo in. Make sure not pierce the skin of the potato, you want it to keep its shape.\r\n\r\nTo the pan, add the chicken stock, butter, pumpkin, honey, garlic, chipotle and adobo sauce, orange zest, juice of 1/2 orange, nutmeg, salt and freshly ground pepper. Mash everything together using a potato masher.\r\n\r\nCarefully refill the potato skin shells with the mashed potato mixture and transfer them back to the baking sheet. Top each potato with some of the reserved crispy chorizo and a small handful of shredded cheese. Place the potatoes under the broiler to melt the cheese, about 1 minute.\r\n\r\nTo serve, top each potato with some chopped scallions and serve a simple salad alongside.", prep_time: 30, cook_time: 120, image_url: "https://www.rachaelrayshow.com/sites/default/files/styles/1100x620/public/images/2018-07/e3d3df46b70f76b21404bf38e34f3802.jpg?itok=o48-G2nP", reheat_time: 20, pepperplate_url: '', notes: '', archived: false }
)
recipe_61 = Recipe.create!(
  { user_id: user.id, title: "Enfrijoladas", source_name: "Budget Bytes", source_url: "https://www.budgetbytes.com/enfrijoladas-tortillas-in-black-bean-sauce/", servings: 6, instructions: "To make the black bean sauce, combine the drained black beans, chipotle peppers plus about 1 Tbsp of the adobo sauce, 1/4 of the sweet onion (diced), cumin, and garlic in a blender or food processor. Starting with one cup, add the broth as you blend until a smooth, thick sauce forms. Taste and adjust the salt as needed (this will depend on the salt content of the broth you use).\r\n\r\nPreheat the oven to 350ºF. Heat the tortillas by either microwaving the stack for 30 seconds, toasting them in a skillet, or directly on a gas burner until lightly browned. Cover the stacked warmed tortillas with foil to retain the heat and steam.\r\n\r\nFinely dice the rest of the sweet onion. Roughly chop the cilantro leaves, add them to the diced onion along with a pinch of salt, and stir to combine. Set the onion and cilantro mixture aside to marinate.\r\n\r\nPour a small amount of the black bean sauce into a casserole dish and spread it around to cover the bottom. Pour more sauce into a wide shallow bowl or dish for dipping the tortillas.\r\n\r\nOne by one, dip the tortillas in the black bean sauce until both sides are coated in the thick sauce. Sprinkle a little cheese and a little of the onion cilantro mixture over half of the tortilla, fold it closed, then fold in half once more to make a triangle. Place the dipped, filled, and folded tortillas in the prepared casserole dish. Be careful to only place a very small amount of filling in the tortillas to make them easier to fold. More filling will be placed on top after baking.\r\n\r\nOnce all the tortillas are dipped, filled, folded, and placed in the casserole dish, pour any remaining black bean sauce over top. Bake the tortillas in the preheated oven for about 15 minutes, or just until heated through. Top with the remaining cheese and onion cilantro mixture after baking, then serve.\r\n\r\nRECIPE NOTES\r\n\r\nI use Better Than Bouillon to mix up broth when I need it and in the amount that I need.", prep_time: 30, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/3daaf5a950cf4ac6a91489feb1f69ddd.jpg?preset=sitethumb", reheat_time: 30, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22709115", notes: '', archived: false }
)
recipe_63 = Recipe.create!(
  { user_id: user.id, title: "Apricot Lentil Soup", source_name: "The Stingy Vegan", source_url: "https://thestingyvegan.com/vegan-lentil-soup/", servings: 4, instructions: "Heat a medium-sized pot over medium-high heat and add a splash of water (or oil if you prefer), the onion and garlic. Fry (add more water as necessary if the pot is dry) until the onion is soft and translucent then add the carrots. Fry until the carrots are beginning to soften then add the apricots and cumin. Give it another minute or so, stirring, until the cumin is fragrant.\r\n\r\nAdd the lentils, can of tomatoes and vegetable stock and bring to a boil. Reduce the heat to medium-low and cover the pot. Simmer very gently until the lentils are tender – about 20 minutes. Use an immersion blender, or remove some of the soup from the pot into a stand blender, and blitz until you reach the consistency that you want. You can make all the soup totally smooth or keep some texture.\r\n\r\nStir in the lemon juice, salt and pepper. Serve the soup garnished with pomegranate seeds and the herb of your choice, if using.", prep_time: 15, cook_time: 30, image_url: "https://thestingyvegan.com/wp-content/uploads/2018/01/vegan-lentil-soup-photo.jpg", reheat_time: 10, pepperplate_url: nil, notes: nil, archived: false }
)
recipe_60 = Recipe.create!(
  { user_id: user.id, title: "Spicy Roasted Cauliflower with Queso", source_name: "Budget Bytes", source_url: "https://www.budgetbytes.com/spicy-roasted-cauliflower-cheese-sauce/", servings: 4, instructions: "Make Queso: <a href=\"http://www.pepperplate.com/recipes/view.aspx?id=22615079\">Cashew Vegan Queso</a>\r\n\r\nPreheat the oven to 400ºF. In a small bowl combine the smoked paprika, granulated garlic, cayenne, salt, and some freshly cracked pepper.\r\n\r\nSpread the frozen cauliflower florets out onto a baking sheet (no need to thaw first), then drizzle with olive oil and sprinkle the spices over top. Toss the cauliflower in the oil and spices until they are fairly evenly coated.\r\n\r\nTransfer the seasoned cauliflower to the preheated oven and roast for 30 minutes, stirring once half way through.\r\n\r\nAbout half way through the roasting time, begin the cheese sauce. Add the evaporated milk and butter to a small sauce pot. Heat over medium, while stirring, until the butter has melted and the evaporated milk is hot. This should only take a couple of minutes.\r\n\r\nTurn the heat under the evaporated milk to LOW and begin whisking in the shredded cheddar, one handful at a time, making sure the cheese is fully melted before adding the next handful. Once all the cheese is melted into the evaporated milk the sauce will thicken. If it's still very liquidy, keep the sauce over low heat and whisk constantly until it thickens. Often the cheese appears to be completely melted, but it has not yet totally emulsified. Remove the cheese sauce from the heat until ready to serve.*\r\n\r\nOnce the cauliflower has finished roasting, divide it into bowls or place it in a serving platter, then pour the cheese sauce over top. Serve immediately.", prep_time: 20, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/4a948fe22cb84ea5b7f55bc7a5c3dff0.jpg", reheat_time: 30, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22615064", notes: '', archived: false }
)
recipe_68 = Recipe.create!(
  { user_id: user.id, title: "Bread Pudding with Roasted Vegetables", source_name: "Taste Love and Nourish", source_url: "http://www.tasteloveandnourish.com/2013/09/16/savory-vegetable-bread-pudding/", servings: 8, instructions: "In a 12 inch skillet over medium high heat, add 2 T. of the olive oil then the onions, celery, red pepper. \r\n\r\nSauté for about two or three minutes then add the mushrooms, eggplant and zucchini. \r\nContinue cooking for another 2 to 3 minutes. Add the tomato, garlic and thyme and cook for just another minute. Season with just a pinch of salt and pepper. Remove from heat and set aside to cool a bit.\r\n\r\nPreheat your oven to 350 degrees.\r\n\r\nSpread the cubes of bread on a large baking sheet. Drizzle 1 T. (or a bit more if needed) of the olive oil over the cubes. Toss to coat. Toast them up a bit in the oven for about 20 minutes, tossing them every so often. When golden, remove from the oven and allow to cool a bit on the sheet.\r\n\r\nIn a medium bowl, beat the eggs then whisk in the milk, salt pepper and nutmeg.\r\n\r\nIn your largest casserole dish, butter the bottom and sides a bit and spread the cubes of bread throughout. Add the veggie mixture and pour the egg mixture over the top. Now, sprinkle the Gruyere in and give it all a little toss to get the cubes coated and to spread the love.\r\n\r\nAt this point, you can cover the dish up with wrap and put it in the fridge for later. Just remember to take the casserole out at least 20 minutes before baking.\r\n\r\nIf you are ready to bake, place the dish in the preheated oven and bake for about 45 minutes.\r\n\r\nRemove from the oven, sprinkle on some fresh parsley (and some fresh thyme if you’ve got some left over) and serve!", prep_time: 45, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/08d4329ba51b4f07ac2a501e5249a9d3.jpg", reheat_time: 15, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=15772212", notes: '', archived: false }
)
recipe_88 = Recipe.create!(
  { user_id: user.id, title: "Sample Archived Recipe", source_name: 'Original Creation', source_url: "/", servings: 10, instructions: "Make the food.", prep_time: 10, cook_time: 20, image_url: "https://images.media-allrecipes.com/userphotos/560x315/3383420.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22709198", notes: "This recipe was poooo! so it's archived now.", archived: true }
)
recipe_59 = Recipe.create!(
  { user_id: user.id, title: "Cashew Vegan Queso", source_name: "Minimalist Baker", source_url: "https://minimalistbaker.com/roasted-jalapeno-vegan-queso-7-ingredients/", servings: 4, instructions: "Be sure to soak your cashews overnight in cool water or in very hot water for 1 hour before starting this recipe. Drain and then proceed with recipe.\r\nPreheat oven to medium broil and add jalapeños to a baking sheet. Broil on the top oven rack for 4-7 minutes or until slightly blackened on the outside. Wrap in foil to steam for a few minutes. Then carefully peel outside skin away and remove any seeds/stems. (Note: Be sure to wash your hands after peeling to avoid getting any lingering heat on your skin or your eyes.)\r\nAdd soaked, drained cashews and jalapeños to a blender along with nutritional yeast, water, chili powder, cumin, granulated garlic, salt, and hot sauce (optional).\r\nBlend, adding more water as needed to create a creamy, pourable cheese sauce. Scrape down sides as needed.\r\nTaste and adjust flavor as needed, adding more nutritional yeast for depth of flavor and cheesiness, remaining jalapeńo or chili powder for heat, cumin for smokiness, salt for saltiness, or hot sauce for additional heat.\r\nServe immediately. Will be fine at room temperature for several hours. Store leftovers covered in the refrigerator up to 5 days. Reheat on the stovetop or in the microwave.", prep_time: 90, cook_time: 0, image_url: "http://cdn2.pepperplate.com/recipes/3e405e27409441d6a9d75d12e7adde0d.jpg?preset=sitethumb", reheat_time: 5, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22615079", notes: '', archived: false }
)
recipe_74 = Recipe.create!(
  { user_id: user.id, title: "Greek Stuffed Peppers", source_name: "Edible Perspecitve", source_url: "http://www.edibleperspective.com/home/2013/10/8/greek-stuffed-peppers.html", servings: 4, instructions: "Bring broth and sundried tomatoes to a boil.\r\n\r\nAdd couscous, cover, and remove from heat.\r\n\r\nCut bell peppers in half, deseed, oil, and roast them for 30 min.\r\n\r\nContinue on to old instructions below. This is WIP\r\n\r\nHeat a pot with a swirl of oil over medium.\r\n\r\nRinse + drain the millet then add to the pot and toast [stirring] for 3-4 minutes.\r\n\r\nAdd the veggie stock and water and bring to a boil.\r\n\r\nStir once then reduce heat to simmer and cover for 20min. Do not stir during this time.\r\n\r\nBe sure the liquid has absorbed [tip the pan to check]\r\nthen remove from the heat and let sit for 10 minutes, keeping covered. Fluff with a fork.\r\nPreheat your oven to broil and lightly oil, salt, and pepper the halved peppers and place on a baking sheet.\r\n\r\nJust as you remove the millet from the burner, heat a large pan over medium and add 2-3 teaspoons of olive oil.\r\n\r\nOnce hot, add the onion and stir occasionally until translucent and soft. About 5-8 minutes.\r\nStir in the garlic, oregano, and black pepper for 30 seconds until fragrant, then add in the chickpeas and cook for about 6-8 minutes until starting to brown.\r\n\r\nWhile cooking, place peppers under the broiler for a 2-4 minutes, then flip and broil for another 2-4 minutes. You want them slightly tender, not limp. Set aside.\r\n\r\nTo your pan add the olives, sun-dried tomatoes, and 2 cups of fluffed millet and stir together.\r\n\r\nAdd in your spinach and incorporate until just starting to wilt, another 3-4 minutes.\r\n\r\nAdd half the feta, lemon juice, and lemon zest, then give it one more stir and taste. Add more salt if desired. The olives, sun-dried tomatoes, and cheese have a hefty amount of sodium so taste and add as desired.\r\n\r\nLightly pack into peppers, top with remaining feta, and place under the broiler until the mixture starts to brown. About 2-3 minutes.\r\n", prep_time: 45, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/e7c04e9e839f4b8a9d8a2f6854e30e24.jpg", reheat_time: 20, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=17619375", notes: '', archived: false }
)
recipe_84 = Recipe.create!(
  { user_id: user.id, title: "Shakshuka", source_name: "Serious Eats", source_url: "http://www.seriouseats.com/recipes/2016/09/shakshuka-north-african-shirred-eggs-tomato-pepper-recipe.html", servings: 4, instructions: "Heat olive oil in a large, deep skillet or straight-sided sauté pan over high heat until shimmering. Add onion, red pepper, and chili and spread into an even layer. Cook, without moving, until vegetables on the bottom are deeply browned and beginning to char in spots, about 6 minutes. Stir and repeat. Continue to cook until vegetables are fully softened and spottily charred, about another 4 minutes. Add garlic and cook, stirring, until softened and fragrant, about 30 seconds. Add paprika and cumin and cook, stirring, until fragrant, about 30 seconds. Immediately add tomatoes and stir to combine (see note above). Reduce heat to a bare simmer and simmer for 10 minutes, then season to taste with salt and pepper and stir in half of cilantro or parsley.\r\n\r\nUsing a large spoon, make a well near the perimeter of the pan and break an egg directly into it. Spoon a little sauce over edges of egg white to partially submerge and contain it, leaving yolk exposed. Repeat with remaining 5 eggs, working around pan as you go. Season eggs with a little salt, cover, reduce heat to lowest setting, and cook until egg whites are barely set and yolks are still runny, 5 to 8 minutes.\r\n\r\nSprinkle with remaining cilantro or parsley, along with any of the optional toppings. Serve immediately with crusty bread.", prep_time: 10, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/c8c943ac278f498a8f62fdce5448ad94.jpg", reheat_time: 10, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=18051887", notes: "vasu says he makes this and he doesn't like lame ass southern indian food\r\n", archived: false }
)
recipe_79 = Recipe.create!(
  { user_id: user.id, title: "Yellow Lentil Dal", source_name: "Food & Wine", source_url: "https://www.foodandwine.com/recipes/yellow-lentil-dal-with-fragrant-basmati-rice", servings: 6, instructions: "Soak the lentils overnight\r\n\r\nIn a large saucepan, combine the yellow lentils with 3 cups of the chicken stock, the ginger and turmeric and bring to a boil. Cover partially and cook over moderate heat, stirring occasionally, until the lentils are just tender, about 20 minutes.\r\n\r\nTransfer 1 cup of the lentils to a food processor or blender and puree until smooth. Return the puree to the saucepan, add the remaining 1 cup of stock and the zucchini and bring to a simmer. Season with salt, cover and cook over moderately low heat, stirring, until the zucchini is tender, about 15 minutes.\r\n\r\nMeanwhile, in a medium skillet, heat the oil until shimmering. Add the mustard seeds and cook over moderate heat, shaking the pan, until they begin to pop, about 30 seconds. Add the onion and cook, stirring occasionally, until softened, about 7 minutes. Add the garlic and serranos and cook for 1 minute. Add the cumin and curry leaves and cook until fragrant, about 1 minute. Add the tomato and cook, stirring, until softened, about 7 minutes. Stir the tomato mixture into the dal and simmer for 5 minutes. Stir in the lemon juice, season with salt and serve with Fragrant Basmati Rice.", prep_time: 20, cook_time: 45, image_url: "http://cdn2.pepperplate.com/recipes/023af666fb0d47869f31b85ec74dca6c.jpg", reheat_time: 15, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=22515951", notes: '', archived: false }
)
recipe_56 = Recipe.create!(
  { user_id: user.id, title: "Creamy Cherry Tomato & Summer Squash Gnocchi", source_name: "Cookie + Kate", source_url: "http://cookieandkate.com/2015/creamy-cherry-tomato-summer-squash-pasta/", servings: 4, instructions: "When Preparing in Advance\r\n\r\n\r\n\r\nDivide all of the veg into 2 containers.\r\n\r\n\r\n\r\nCook the gnocchi when you plan to eat it, not in advance\r\n\r\n\r\n\r\nUse 8oz of a 16oz package for each 2-person meal\r\n\r\n\r\n\r\nGeneral Prep Notes\r\n\r\n\r\n\r\nPreheat oven to 400F\r\n\r\n\r\n\r\nSlice the squashes and zucchini into half moons that are about 1/8 inch thick\r\n\r\n\r\n\r\nLube up the baking tray\r\n\r\n\r\n\r\nPlace the squashes and zucchini and whole cherry tomatoes on the baking tray in a single layer\r\n\r\n\r\n\r\nSprinkle with salt and pepper\r\n\r\n\r\n\r\nRoast for about 25 minutes, stirring to keep from sticking\r\n\r\n\r\n\r\nIt's done when the cherry tomatoes have burst and the squash is tender.\r\n\r\n\r\n\r\nCook the pasta (Use the large soup pot because we're going to put the pasta back in it) NOTE: Don't drain the pasta without consulting the next step.\r\n\r\n\r\n\r\nSet aside about a cup of pasta water when you strain the pasta.\r\n\r\n\r\n\r\nAdd 2 TBSP oil to the bottom of the soup pot then put the pasta back in and stir.\r\n\r\n\r\n\r\nImmediately add the goat cheese, garlic, and red pepper flakes\r\n\r\n\r\n\r\nPut the small mesh strainer over the pot and juice the lemon into the mix. (you may have to put one end of the strainer on the pot and the other on a wooden spoon across the pot)\r\n\r\n\r\n\r\nAdd about 1/4 cup of the reserved pasta cooking water and gently toss the pasta until the ingredients are evenly mixed together and the pasta is coated in a light sauce (add more reserved cooking water if the pasta seems dry).\r\n\r\n\r\n\r\nOnce the tomatoes and squash are done, pour the whole thing into the pot, jusices and all\r\n\r\n\r\n\r\nSeason to taste with salt and pepper\r\n\r\n\r\n\r\nStir in the basil and oregano", prep_time: 10, cook_time: 30, image_url: "http://cdn2.pepperplate.com/recipes/5b2d05dbb7f34128a19cd42869d30848.jpg", reheat_time: 30, pepperplate_url: "http://www.pepperplate.com/recipes/view.aspx?id=16885372", notes: '', archived: false }
)

Ingredient.create!([
  {recipe_id: recipe_49.id, quantity: 8.0, measurement_unit: "slice", name: "muenster cheese", preparation_style: '' },
  {recipe_id: recipe_49.id, quantity: 1.0, measurement_unit: "cup", name: "cucumber", preparation_style: "sliced" },
  {recipe_id: recipe_49.id, quantity: 2.0, measurement_unit: "whole", name: "tomato", preparation_style: "sliced" },
  {recipe_id: recipe_49.id, quantity: 0.5, measurement_unit: "whole", name: "red bell pepper", preparation_style: "matchsticked" },
  {recipe_id: recipe_49.id, quantity: 0.5, measurement_unit: "whole", name: "green bell pepper", preparation_style: "matchsticked" },
  {recipe_id: recipe_49.id, quantity: 0.25, measurement_unit: "cup", name: "pitted black olives", preparation_style: "sliced" },
  {recipe_id: recipe_49.id, quantity: 3.0, measurement_unit: "cup", name: "salad greens", preparation_style: "chopped" },
  {recipe_id: recipe_49.id, quantity: 4.0, measurement_unit: "whole", name: "po'boy rolls", preparation_style: '' },
  {recipe_id: recipe_49.id, quantity: 2.0, measurement_unit: "tsp", name: "dried oregano", preparation_style: '' },
  {recipe_id: recipe_49.id, quantity: 12.0, measurement_unit: "leaf", name: "fresh basil", preparation_style: "chopped" },
  {recipe_id: recipe_50.id, quantity: 1.0, measurement_unit: "whole", name: "plaintain maduro", preparation_style: "sliced" },
  {recipe_id: recipe_50.id, quantity: 3.0, measurement_unit: "sprig", name: "fresh cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_50.id, quantity: 1.0, measurement_unit: "T", name: "adobo seasoning", preparation_style: '' },
  {recipe_id: recipe_50.id, quantity: 2.0, measurement_unit: "ounce", name: "queso blanco", preparation_style: "crumbled" },
  {recipe_id: recipe_50.id, quantity: 2.0, measurement_unit: "can", name: "canned black beans", preparation_style: "finely chopped" },
  {recipe_id: recipe_50.id, quantity: 1.0, measurement_unit: "T", name: "brown cane sugar", preparation_style: "grated" },
  {recipe_id: recipe_50.id, quantity: 1.0, measurement_unit: "T", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_50.id, quantity: 0.75, measurement_unit: "cup", name: "onion", preparation_style: "finely chopped" },
  {recipe_id: recipe_50.id, quantity: 0.25, measurement_unit: "whole", name: "red bell pepper", preparation_style: "finely chopped" },
  {recipe_id: recipe_50.id, quantity: 0.25, measurement_unit: "whole", name: "green bell pepper", preparation_style: "finely chopped" },
  {recipe_id: recipe_51.id, quantity: 0.25, measurement_unit: "cup", name: "peanut butter", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 0.5, measurement_unit: "cup", name: "red bell pepper", preparation_style: "finely chopped" },
  {recipe_id: recipe_51.id, quantity: 1.0, measurement_unit: "T", name: "soy sauce", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 1.0, measurement_unit: "tsp", name: "brown sugar", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 0.5, measurement_unit: "T", name: "rice vinegar", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 8.0, measurement_unit: "ounce", name: "spaghetti", preparation_style: "cooked" },
  {recipe_id: recipe_51.id, quantity: 1.0, measurement_unit: "tsp", name: "crushed red pepper", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 4.0, measurement_unit: "sprig", name: "fresh cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_52.id, quantity: 1.0, measurement_unit: "can", name: "coconut milk", preparation_style: '' },
  {recipe_id: recipe_52.id, quantity: 3.0, measurement_unit: "cup", name: "water", preparation_style: '' },
  {recipe_id: recipe_52.id, quantity: 0.333, measurement_unit: "cup", name: "dry red lentils", preparation_style: "sorted" },
  {recipe_id: recipe_52.id, quantity: 0.333, measurement_unit: "cup", name: "dry brown lentils", preparation_style: "sorted" },
  {recipe_id: recipe_52.id, quantity: 0.125, measurement_unit: "cup", name: "couscous", preparation_style: "uncooked" },
  {recipe_id: recipe_52.id, quantity: 2.0, measurement_unit: "leaf", name: "bay leaf", preparation_style: '' },
  {recipe_id: recipe_52.id, quantity: 0.5, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_52.id, quantity: 2.0, measurement_unit: "stalk", name: "celery", preparation_style: "finely chopped" },
  {recipe_id: recipe_52.id, quantity: 2.0, measurement_unit: "whole", name: "carrot", preparation_style: "finely chopped" },
  {recipe_id: recipe_53.id, quantity: 1.0, measurement_unit: "T", name: "olive oil", preparation_style: '' },
  {recipe_id: recipe_53.id, quantity: 1.0, measurement_unit: "tsp", name: "cumin", preparation_style: "ground" },
  {recipe_id: recipe_53.id, quantity: 2.0, measurement_unit: "whole", name: "carrot", preparation_style: "chopped" },
  {recipe_id: recipe_53.id, quantity: 1.0, measurement_unit: "cup", name: "dry red lentils", preparation_style: "sorted" },
  {recipe_id: recipe_53.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_53.id, quantity: 1.0, measurement_unit: "loaf", name: "crusty bread", preparation_style: "sliced" },
  {recipe_id: recipe_54.id, quantity: 1.0, measurement_unit: "whole", name: "pie crust", preparation_style: '' },
  {recipe_id: recipe_54.id, quantity: 1.0, measurement_unit: "whole", name: "tomato", preparation_style: "diced" },
  {recipe_id: recipe_54.id, quantity: 6.0, measurement_unit: "ounce", name: "frozen chopped spinach", preparation_style: "thawed" },
  {recipe_id: recipe_54.id, quantity: 0.5, measurement_unit: "dozen", name: "egg", preparation_style: '' },
  {recipe_id: recipe_54.id, quantity: 0.25, measurement_unit: "cup", name: "feta", preparation_style: "crumbled" },
  {recipe_id: recipe_54.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_54.id, quantity: 0.125, measurement_unit: "tsp", name: "onion powder", preparation_style: '' },
  {recipe_id: recipe_54.id, quantity: 0.5, measurement_unit: "tsp", name: "basil", preparation_style: "dried" },
  {recipe_id: recipe_54.id, quantity: 0.5, measurement_unit: "tsp", name: "oregano", preparation_style: "dried" },
  {recipe_id: recipe_54.id, quantity: 0.125, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 2.0, measurement_unit: "cup", name: "onion", preparation_style: "chopped" },
  {recipe_id: recipe_55.id, quantity: 2.0, measurement_unit: "cup", name: "tomato", preparation_style: "diced" },
  {recipe_id: recipe_55.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 1.0, measurement_unit: "T", name: "fresh ginger root", preparation_style: "minced" },
  {recipe_id: recipe_55.id, quantity: 0.5, measurement_unit: "tsp", name: "garam masala", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 0.75, measurement_unit: "tsp", name: "curry powder", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 0.25, measurement_unit: "tsp", name: "cumin", preparation_style: "ground" },
  {recipe_id: recipe_55.id, quantity: 1.0, measurement_unit: "T", name: "red curry paste", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 1.0, measurement_unit: "cup", name: "dry red lentils", preparation_style: "sorted" },
  {recipe_id: recipe_55.id, quantity: 2.0, measurement_unit: "cup", name: "water", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 1.0, measurement_unit: "can", name: "coconut milk", preparation_style: '' },
  {recipe_id: recipe_55.id, quantity: 0.5, measurement_unit: "cup", name: "rice", preparation_style: "uncooked" },
  {recipe_id: recipe_56.id, quantity: 16.0, measurement_unit: "ounce", name: "gnocchi", preparation_style: "uncooked" },
  {recipe_id: recipe_56.id, quantity: 1.0, measurement_unit: "pint", name: "cherry tomato", preparation_style: "sliced in half" },
  {recipe_id: recipe_56.id, quantity: 2.0, measurement_unit: "whole", name: "yellow squash", preparation_style: "sliced" },
  {recipe_id: recipe_56.id, quantity: 1.0, measurement_unit: "whole", name: "zucchini", preparation_style: "sliced" },
  {recipe_id: recipe_56.id, quantity: 2.0, measurement_unit: "T", name: "olive oil", preparation_style: '' },
  {recipe_id: recipe_56.id, quantity: 2.0, measurement_unit: "T", name: "lemon juice", preparation_style: '' },
  {recipe_id: recipe_56.id, quantity: 1.0, measurement_unit: "ounce", name: "goat cheese", preparation_style: "crumbled" },
  {recipe_id: recipe_56.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_56.id, quantity: 0.5, measurement_unit: "tsp", name: "crushed red pepper flakes", preparation_style: '' },
  {recipe_id: recipe_56.id, quantity: 8.0, measurement_unit: "leaf", name: "fresh basil", preparation_style: "chopped" },
  {recipe_id: recipe_56.id, quantity: 1.0, measurement_unit: "tsp", name: "oregano", preparation_style: "dried" },
  {recipe_id: recipe_69.id, quantity: 0.5, measurement_unit: "bunch", name: "green onion", preparation_style: "for serving" },
  {recipe_id: recipe_69.id, quantity: 1.0, measurement_unit: "cup", name: "salsa", preparation_style: "for serving" },
  {recipe_id: recipe_70.id, quantity: 8.0, measurement_unit: "ounce", name: "colby jack cheese", preparation_style: "shredded" },
  {recipe_id: recipe_70.id, quantity: 8.0, measurement_unit: "ounce", name: "yogurt", preparation_style: '' },
  {recipe_id: recipe_70.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_52.id, quantity: 0.25, measurement_unit: "cup", name: "dry yellow lentils", preparation_style: "sorted" },
  {recipe_id: recipe_53.id, quantity: 1.0, measurement_unit: "cup", name: "onion", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 1.0, measurement_unit: "cup", name: "raw cashews", preparation_style: "soaked in hot water for 1 hour" },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "cup", name: "nutritional yeast", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "cup", name: "water", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 1.0, measurement_unit: "whole", name: "jalapeño pepper", preparation_style: "deseeded and chopped" },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "tsp", name: "chili powder", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "tsp", name: "cumin", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 0.5, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_59.id, quantity: 1.0, measurement_unit: "T", name: "honey", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 2.0, measurement_unit: "can", name: "black beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_61.id, quantity: 7.0, measurement_unit: "ounce", name: "chipotle peppers in adobo sauce", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 0.5, measurement_unit: "tsp", name: "onion powder", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 0.5, measurement_unit: "tsp", name: "cumin", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 2.0, measurement_unit: "cup", name: "water", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 12.0, measurement_unit: "whole", name: "corn tortillas (small)", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 1.0, measurement_unit: "bunch", name: "cilantro", preparation_style: '' },
  {recipe_id: recipe_61.id, quantity: 4.0, measurement_unit: "ounce", name: "queso fresco", preparation_style: '' },
  {recipe_id: recipe_60.id, quantity: 24.0, measurement_unit: "ounce", name: "frozen cauliflower", preparation_style: "thawed to about room temp" },
  {recipe_id: recipe_60.id, quantity: 0.5, measurement_unit: "T", name: "smoked paprika", preparation_style: '' },
  {recipe_id: recipe_60.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_60.id, quantity: 0.25, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_60.id, quantity: 1.0, measurement_unit: "T", name: "olive oil", preparation_style: '' },
  {recipe_id: recipe_63.id, quantity: 1.0, measurement_unit: "whole", name: "onion", preparation_style: "diced" },
  {recipe_id: recipe_63.id, quantity: 2.0, measurement_unit: "clove", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_63.id, quantity: 2.0, measurement_unit: "whole", name: "carrot", preparation_style: "peeled and diced" },
  {recipe_id: recipe_63.id, quantity: 0.5, measurement_unit: "cup", name: "dried apricots", preparation_style: "finely diced" },
  {recipe_id: recipe_63.id, quantity: 1.0, measurement_unit: "tsp", name: "cumin", preparation_style: '' },
  {recipe_id: recipe_63.id, quantity: 1.5, measurement_unit: "cup", name: "dried red lentils", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_63.id, quantity: 1.0, measurement_unit: "can", name: "canned diced tomatoes", preparation_style: '' },
  {recipe_id: recipe_63.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 0.5, measurement_unit: "cup", name: "yellow onion", preparation_style: "diced" },
  {recipe_id: recipe_64.id, quantity: 0.5, measurement_unit: "whole", name: "green bell pepper", preparation_style: "diced" },
  {recipe_id: recipe_64.id, quantity: 2.0, measurement_unit: "clove", name: "garlic", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 1.0, measurement_unit: "can", name: "pigeon peas", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_64.id, quantity: 4.0, measurement_unit: "ounce", name: "tomato sauce", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 3.0, measurement_unit: "cup", name: "water", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 1.0, measurement_unit: "tsp", name: "cumin", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 1.0, measurement_unit: "tsp", name: "coriander", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 1.0, measurement_unit: "tsp", name: "paprika", preparation_style: '' },
  {recipe_id: recipe_68.id, quantity: 2.0, measurement_unit: "T", name: "fresh parsley", preparation_style: "chopped" },
  {recipe_id: recipe_64.id, quantity: 0.333, measurement_unit: "cup", name: "coconut flakes", preparation_style: "toasted" },
  {recipe_id: recipe_60.id, quantity: 0.125, measurement_unit: "tsp", name: "cayenne pepper", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "bunch", name: "curly kale", preparation_style: "washed, deboned, chopped, and squeezed" },
  {recipe_id: recipe_67.id, quantity: 0.5, measurement_unit: "whole", name: "avocado", preparation_style: "cubed" },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "whole", name: "red bell pepper", preparation_style: "chopped" },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "whole", name: "carrot", preparation_style: "peeled and julienned" },
  {recipe_id: recipe_67.id, quantity: 0.125, measurement_unit: "bunch", name: "cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "T", name: "red onion", preparation_style: "minced" },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "tsp", name: "sesame seeds", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "bunch", name: "brocolini", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 0.25, measurement_unit: "cup", name: "red cabbage", preparation_style: "chopped" },
  {recipe_id: recipe_67.id, quantity: 2.0, measurement_unit: "T", name: "apple cider vinegar", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "whole", name: "lime", preparation_style: "juiced" },
  {recipe_id: recipe_67.id, quantity: 2.0, measurement_unit: "T", name: "honey", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 3.0, measurement_unit: "T", name: "olive oil", preparation_style: '' },
  {recipe_id: recipe_67.id, quantity: 1.0, measurement_unit: "inch", name: "ginger", preparation_style: "peeled and minced" },
  {recipe_id: recipe_68.id, quantity: 1.0, measurement_unit: "whole", name: "baguette", preparation_style: "cut into big cubes and dried" },
  {recipe_id: recipe_68.id, quantity: 1.0, measurement_unit: "T", name: "olive oil", preparation_style: '' },
  {recipe_id: recipe_68.id, quantity: 1.0, measurement_unit: "whole", name: "onion", preparation_style: "diced" },
  {recipe_id: recipe_68.id, quantity: 2.0, measurement_unit: "stalk", name: "celery", preparation_style: "roughly chopped" },
  {recipe_id: recipe_68.id, quantity: 1.0, measurement_unit: "whole", name: "red bell pepper", preparation_style: "roughly chopped" },
  {recipe_id: recipe_68.id, quantity: 8.0, measurement_unit: "ounce", name: "mushrooms", preparation_style: "washed and roughly sliced" },
  {recipe_id: recipe_68.id, quantity: 2.0, measurement_unit: "whole", name: "zucchini", preparation_style: "sliced into thick half moons" },
  {recipe_id: recipe_68.id, quantity: 1.0, measurement_unit: "whole", name: "tomato", preparation_style: "roughly chopped" },
  {recipe_id: recipe_68.id, quantity: 2.0, measurement_unit: "clove", name: "garlic", preparation_style: "sliced" },
  {recipe_id: recipe_68.id, quantity: 0.5, measurement_unit: "tsp", name: "dried thyme", preparation_style: "crumbled" },
  {recipe_id: recipe_68.id, quantity: 5.0, measurement_unit: "whole", name: "egg", preparation_style: '' },
  {recipe_id: recipe_68.id, quantity: 0.5, measurement_unit: "T", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_68.id, quantity: 0.25, measurement_unit: "tsp", name: "ground nutmeg", preparation_style: '' },
  {recipe_id: recipe_68.id, quantity: 2.0, measurement_unit: "cup", name: "gruyere", preparation_style: "or swiss, grated" },
  {recipe_id: recipe_69.id, quantity: 16.0, measurement_unit: "ounce", name: "extra firm tofu", preparation_style: "drained and crumbled" },
  {recipe_id: recipe_69.id, quantity: 6.0, measurement_unit: "whole", name: "flour tortilla (burrito size)", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 1.0, measurement_unit: "whole", name: "potato", preparation_style: "cubed and steamed" },
  {recipe_id: recipe_69.id, quantity: 0.5, measurement_unit: "cup", name: "white onion", preparation_style: "diced" },
  {recipe_id: recipe_69.id, quantity: 0.75, measurement_unit: "cup", name: "red bell pepper", preparation_style: "diced" },
  {recipe_id: recipe_69.id, quantity: 1.0, measurement_unit: "whole", name: "anaheim pepper", preparation_style: "finely chopped" },
  {recipe_id: recipe_69.id, quantity: 0.25, measurement_unit: "tsp", name: "ground coriander", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 0.5, measurement_unit: "tsp", name: "cumin", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 0.5, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 1.25, measurement_unit: "tsp", name: "turmeric", preparation_style: '' },
  {recipe_id: recipe_69.id, quantity: 0.25, measurement_unit: "cup", name: "yogurt", preparation_style: "for serving" },
  {recipe_id: recipe_68.id, quantity: 0.5, measurement_unit: "cup", name: "milk", preparation_style: '' },
  {recipe_id: recipe_64.id, quantity: 2.0, measurement_unit: "cup", name: "uncooked white rice", preparation_style: '' },
  {recipe_id: recipe_70.id, quantity: 1.0, measurement_unit: "tsp", name: "vegetable bouillon", preparation_style: '' },
  {recipe_id: recipe_71.id, quantity: 16.0, measurement_unit: "ounce", name: "sweet potato gnocchi", preparation_style: '' },
  {recipe_id: recipe_71.id, quantity: 1.0, measurement_unit: "bunch", name: "broccolini", preparation_style: "chopped into bit-size pieces" },
  {recipe_id: recipe_71.id, quantity: 4.0, measurement_unit: "T", name: "butter", preparation_style: '' },
  {recipe_id: recipe_71.id, quantity: 0.125, measurement_unit: "tsp", name: "ground nutmeg", preparation_style: '' },
  {recipe_id: recipe_71.id, quantity: 0.125, measurement_unit: "tsp", name: "cinnamon", preparation_style: '' },
  {recipe_id: recipe_71.id, quantity: 0.5, measurement_unit: "ounce", name: "goat cheese", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 16.0, measurement_unit: "ounce", name: "frozen sweet corn", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 1.0, measurement_unit: "whole", name: "onion", preparation_style: "chopped" },
  {recipe_id: recipe_72.id, quantity: 0.5, measurement_unit: "T", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 2.0, measurement_unit: "stalk", name: "celery", preparation_style: "chopped" },
  {recipe_id: recipe_72.id, quantity: 2.0, measurement_unit: "whole", name: "carrot", preparation_style: "chopped" },
  {recipe_id: recipe_72.id, quantity: 1.0, measurement_unit: "whole", name: "red bell pepper", preparation_style: "diced" },
  {recipe_id: recipe_72.id, quantity: 0.125, measurement_unit: "bunch", name: "fresh parsley", preparation_style: "roughly chopped" },
  {recipe_id: recipe_72.id, quantity: 1.0, measurement_unit: "can", name: "coconut milk", preparation_style: "well shaken" },
  {recipe_id: recipe_72.id, quantity: 2.0, measurement_unit: "T", name: "flour", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 0.5, measurement_unit: "tsp", name: "cayenne pepper", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 0.75, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_72.id, quantity: 0.5, measurement_unit: "tsp", name: "ground nutmeg", preparation_style: '' },
  {recipe_id: recipe_63.id, quantity: 0.25, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 2.0, measurement_unit: "whole", name: "leek", preparation_style: "chopped, soaked, washed, drained" },
  {recipe_id: recipe_73.id, quantity: 3.0, measurement_unit: "stalk", name: "celery", preparation_style: "diced" },
  {recipe_id: recipe_73.id, quantity: 1.0, measurement_unit: "whole", name: "russet potato", preparation_style: "diced" },
  {recipe_id: recipe_73.id, quantity: 6.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 1.0, measurement_unit: "can", name: "coconut milk", preparation_style: "shaken" },
  {recipe_id: recipe_73.id, quantity: 0.5, measurement_unit: "tsp", name: "dried thyme", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 0.25, measurement_unit: "tsp", name: "dried rosemary", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 2.0, measurement_unit: "whole", name: "bay leaf", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 0.5, measurement_unit: "whole", name: "butter", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 0.25, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_73.id, quantity: 0.25, measurement_unit: "cup", name: "almonds", preparation_style: "sliced or chopped" },
  {recipe_id: recipe_73.id, quantity: 2.0, measurement_unit: "T", name: "sunflower seeds", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 1.0, measurement_unit: "cup", name: "uncooked couscous", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 2.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 0.25, measurement_unit: "cup", name: "sundried tomatoes", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 2.0, measurement_unit: "whole", name: "red bell pepper", preparation_style: "cut in half like boats and deseeded" },
  {recipe_id: recipe_74.id, quantity: 0.25, measurement_unit: "whole", name: "green bell pepper", preparation_style: "diced" },
  {recipe_id: recipe_74.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 0.25, measurement_unit: "tsp", name: "onion powder", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 1.0, measurement_unit: "T", name: "dried oregano", preparation_style: '' },
  {recipe_id: recipe_74.id, quantity: 1.0, measurement_unit: "can", name: "black eyed peas", preparation_style: "drained and rinsed" },
  {recipe_id: recipe_74.id, quantity: 0.25, measurement_unit: "cup", name: "kalamata olived", preparation_style: "pitted and diced" },
  {recipe_id: recipe_74.id, quantity: 6.0, measurement_unit: "handful", name: "baby spinach", preparation_style: "chopped" },
  {recipe_id: recipe_74.id, quantity: 4.0, measurement_unit: "ounce", name: "feta cheese", preparation_style: "crumbled" },
  {recipe_id: recipe_74.id, quantity: 2.0, measurement_unit: "T", name: "pine nuts", preparation_style: "toasted" },
  {recipe_id: recipe_75.id, quantity: 10.0, measurement_unit: "ounce", name: "plain jackfruit", preparation_style: "rinsed, drained, chopped" },
  {recipe_id: recipe_75.id, quantity: 0.25, measurement_unit: "tsp", name: "onion powder", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 1.0, measurement_unit: "stalk", name: "celery", preparation_style: "minced" },
  {recipe_id: recipe_75.id, quantity: 0.5, measurement_unit: "tsp", name: "dried tarragon", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 1.0, measurement_unit: "whole", name: "tomato", preparation_style: "half-mooned and sliced" },
  {recipe_id: recipe_75.id, quantity: 1.0, measurement_unit: "can", name: "great northern beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_75.id, quantity: 0.25, measurement_unit: "cup", name: "mayonnaise", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 1.5, measurement_unit: "T", name: "dijon mustard", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 2.0, measurement_unit: "T", name: "pickled relish", preparation_style: '' },
  {recipe_id: recipe_75.id, quantity: 1.0, measurement_unit: "loaf", name: "marble rye", preparation_style: "sliced" },
  {recipe_id: recipe_75.id, quantity: 12.0, measurement_unit: "slice", name: "sliced swiss cheese", preparation_style: '' },
  {recipe_id: recipe_76.id, quantity: 5.0, measurement_unit: "whole", name: "carrot", preparation_style: "finely chopped" },
  {recipe_id: recipe_76.id, quantity: 5.0, measurement_unit: "stalk", name: "celery", preparation_style: "finely chopped" },
  {recipe_id: recipe_76.id, quantity: 0.5, measurement_unit: "whole", name: "onion", preparation_style: "diced" },
  {recipe_id: recipe_76.id, quantity: 1.0, measurement_unit: "cup", name: "uncooked wild rice", preparation_style: '' },
  {recipe_id: recipe_76.id, quantity: 8.0, measurement_unit: "ounce", name: "fresh mushrooms", preparation_style: "sliced" },
  {recipe_id: recipe_76.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: "to start. Add more as needed." },
  {recipe_id: recipe_76.id, quantity: 1.0, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_76.id, quantity: 0.5, measurement_unit: "tsp", name: "dried thyme", preparation_style: '' },
  {recipe_id: recipe_76.id, quantity: 1.5, measurement_unit: "cup", name: "milk", preparation_style: '' },
  {recipe_id: recipe_51.id, quantity: 0.5, measurement_unit: "box", name: "extra firm tofu", preparation_style: "drained, crumbled" },
  {recipe_id: recipe_51.id, quantity: 1.0, measurement_unit: "whole", name: "carrot", preparation_style: "julienned" },
  {recipe_id: recipe_72.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_70.id, quantity: 2.5, measurement_unit: "whole", name: "potato", preparation_style: "thinly sliced" },
  {recipe_id: recipe_72.id, quantity: 2.0, measurement_unit: "whole", name: "potato", preparation_style: "cubed" },
  {recipe_id: recipe_70.id, quantity: 0.5, measurement_unit: "bunch", name: "green onion", preparation_style: "chopped" },
  {recipe_id: recipe_70.id, quantity: 1.0, measurement_unit: "whole", name: "pizza crust", preparation_style: "premade" },
  {recipe_id: recipe_77.id, quantity: 8.0, measurement_unit: "ounce", name: "dried spaghetti", preparation_style: "cooked" },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "can", name: "great northern beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "T", name: "peanut butter", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "T", name: "red curry paste", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "tsp", name: "mustard", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 0.25, measurement_unit: "tsp", name: "ground ginger", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "tsp", name: "rice vinegar", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 1.0, measurement_unit: "T", name: "soy sauce", preparation_style: '' },
  {recipe_id: recipe_77.id, quantity: 2.0, measurement_unit: "whole", name: "zucchini (medium)", preparation_style: "julienned" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "whole", name: "poblano pepper", preparation_style: "diced" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "whole", name: "white onion", preparation_style: "diced" },
  {recipe_id: recipe_78.id, quantity: 2.0, measurement_unit: "clove", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "whole", name: "jalapeño pepper", preparation_style: "minced" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "tsp", name: "ground cumin", preparation_style: '' },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "can", name: "crushed tomatoes", preparation_style: '' },
  {recipe_id: recipe_78.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "can", name: "hominy", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_78.id, quantity: 4.0, measurement_unit: "whole", name: "radishes", preparation_style: "sliced into thin rounds" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "can", name: "black beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_78.id, quantity: 1.0, measurement_unit: "handful", name: "cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_79.id, quantity: 4.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_79.id, quantity: 2.0, measurement_unit: "T", name: "fresh ginger", preparation_style: "minced" },
  {recipe_id: recipe_79.id, quantity: 0.5, measurement_unit: "tsp", name: "ground turmeric", preparation_style: '' },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "whole", name: "zucchini", preparation_style: "cut into 1\" pieces" },
  {recipe_id: recipe_79.id, quantity: 1.5, measurement_unit: "tsp", name: "black mustard seeds", preparation_style: '' },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "whole", name: "yellow onion", preparation_style: "halved and thinly sliced" },
  {recipe_id: recipe_79.id, quantity: 2.0, measurement_unit: "clove", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_79.id, quantity: 2.0, measurement_unit: "whole", name: "bay leaf", preparation_style: '' },
  {recipe_id: recipe_79.id, quantity: 2.0, measurement_unit: "tsp", name: "ground cumin", preparation_style: '' },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "whole", name: "tomato", preparation_style: "cubed" },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "whole", name: "anaheim", preparation_style: "thinly sliced and deseeded" },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "cup", name: "dry yellow lentils", preparation_style: '' },
  {recipe_id: recipe_80.id, quantity: 1.0, measurement_unit: "whole", name: "yellow onion", preparation_style: "diced" },
  {recipe_id: recipe_80.id, quantity: 3.0, measurement_unit: "stalk", name: "celery", preparation_style: "chopped" },
  {recipe_id: recipe_80.id, quantity: 1.0, measurement_unit: "whole", name: "carrot", preparation_style: "peeled and chopped" },
  {recipe_id: recipe_80.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_80.id, quantity: 0.5, measurement_unit: "tsp", name: "powdered jalapeño pepper", preparation_style: '' },
  {recipe_id: recipe_80.id, quantity: 3.0, measurement_unit: "can", name: "black beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_80.id, quantity: 1.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_80.id, quantity: 0.25, measurement_unit: "cup", name: "fresh cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_80.id, quantity: 1.0, measurement_unit: "tsp", name: "vinegar", preparation_style: '' },
  {recipe_id: recipe_81.id, quantity: 1.0, measurement_unit: "bunch", name: "broccolini", preparation_style: "cut into large bite sizes" },
  {recipe_id: recipe_81.id, quantity: 2.0, measurement_unit: "inch", name: "fresh ginger root", preparation_style: "peeled and minced" },
  {recipe_id: recipe_81.id, quantity: 2.0, measurement_unit: "whole", name: "carrot", preparation_style: "julienned" },
  {recipe_id: recipe_81.id, quantity: 2.0, measurement_unit: "stalk", name: "celery", preparation_style: "chopped at an angle" },
  {recipe_id: recipe_81.id, quantity: 0.25, measurement_unit: "whole", name: "onion", preparation_style: "sliced into thin half moons" },
  {recipe_id: recipe_81.id, quantity: 0.125, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_81.id, quantity: 3.0, measurement_unit: "whole", name: "baby bok choi", preparation_style: "chopped" },
  {recipe_id: recipe_81.id, quantity: 2.0, measurement_unit: "tsp", name: "vinegar", preparation_style: '' },
  {recipe_id: recipe_81.id, quantity: 1.0, measurement_unit: "T", name: "honey", preparation_style: '' },
  {recipe_id: recipe_81.id, quantity: 1.0, measurement_unit: "T", name: "soy sauce", preparation_style: '' },
  {recipe_id: recipe_81.id, quantity: 0.25, measurement_unit: "tsp", name: "crushed red pepper", preparation_style: '' },
  {recipe_id: recipe_82.id, quantity: 1.0, measurement_unit: "whole", name: "sweet potato", preparation_style: "cut into small dice" },
  {recipe_id: recipe_82.id, quantity: 0.5, measurement_unit: "lb", name: "mexican chorizo", preparation_style: '' },
  {recipe_id: recipe_82.id, quantity: 1.0, measurement_unit: "can", name: "black beans", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_82.id, quantity: 1.0, measurement_unit: "cup", name: "uncooked white rice", preparation_style: '' },
  {recipe_id: recipe_82.id, quantity: 1.0, measurement_unit: "cup", name: "salsa", preparation_style: '' },
  {recipe_id: recipe_82.id, quantity: 1.75, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_82.id, quantity: 1.0, measurement_unit: "cup", name: "shredded cheddar cheese", preparation_style: "for garnish" },
  {recipe_id: recipe_82.id, quantity: 2.0, measurement_unit: "stalk", name: "green onion", preparation_style: "chopped, for garnish" },
  {recipe_id: recipe_83.id, quantity: 1.0, measurement_unit: "cup", name: "white onion", preparation_style: "diced" },
  {recipe_id: recipe_83.id, quantity: 0.25, measurement_unit: "tsp", name: "granulated garlic", preparation_style: '' },
  {recipe_id: recipe_83.id, quantity: 0.5, measurement_unit: "tsp", name: "ground cumin", preparation_style: '' },
  {recipe_id: recipe_83.id, quantity: 0.125, measurement_unit: "cup", name: "nutritional yeast", preparation_style: '' },
  {recipe_id: recipe_83.id, quantity: 1.0, measurement_unit: "can", name: "lentils", preparation_style: "rinsed and drained" },
  {recipe_id: recipe_83.id, quantity: 1.0, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_83.id, quantity: 8.0, measurement_unit: "ounce", name: "wide egg noodles", preparation_style: '' },
  {recipe_id: recipe_83.id, quantity: 4.0, measurement_unit: "cup", name: "kale", preparation_style: "thinly sliced" },
  {recipe_id: recipe_83.id, quantity: 0.33, measurement_unit: "cup", name: "parmesan", preparation_style: "grated" },
  {recipe_id: recipe_84.id, quantity: 1.0, measurement_unit: "whole", name: "yellow onion", preparation_style: "thinly sliced" },
  {recipe_id: recipe_84.id, quantity: 1.0, measurement_unit: "whole", name: "red bell pepper", preparation_style: "diced" },
  {recipe_id: recipe_84.id, quantity: 1.0, measurement_unit: "whole", name: "jalapeño pepper", preparation_style: "deseeded and sliced" },
  {recipe_id: recipe_84.id, quantity: 3.0, measurement_unit: "clove", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_84.id, quantity: 1.5, measurement_unit: "T", name: "smoked paprika", preparation_style: '' },
  {recipe_id: recipe_84.id, quantity: 2.0, measurement_unit: "tsp", name: "ground cumin", preparation_style: '' },
  {recipe_id: recipe_84.id, quantity: 28.0, measurement_unit: "ounce", name: "canned diced tomatoes", preparation_style: '' },
  {recipe_id: recipe_84.id, quantity: 6.0, measurement_unit: "whole", name: "egg", preparation_style: '' },
  {recipe_id: recipe_84.id, quantity: 10.0, measurement_unit: "whole", name: "kalamata olive", preparation_style: "pitted and sliced in half" },
  {recipe_id: recipe_84.id, quantity: 1.0, measurement_unit: "handful", name: "cilantro", preparation_style: "chopped" },
  {recipe_id: recipe_84.id, quantity: 4.0, measurement_unit: "ounce", name: "feta cheese", preparation_style: "for serving" },
  {recipe_id: recipe_79.id, quantity: 1.0, measurement_unit: "cup", name: "uncooked jasmine rice", preparation_style: "cooked" },
  {recipe_id: recipe_81.id, quantity: 1.0, measurement_unit: "cup", name: "uncooked white rice", preparation_style: "cooked" },
  {recipe_id: recipe_85.id, quantity: 2.0, measurement_unit: "whole", name: "sweet potato", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 0.5, measurement_unit: "cup", name: "brown sugar", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 0.25, measurement_unit: "cup", name: "cane juice sugar", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 1.0, measurement_unit: "T", name: "cinnamon", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 0.5, measurement_unit: "tsp", name: "ground nutmeg", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 0.25, measurement_unit: "tsp", name: "ground ginger", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 0.25, measurement_unit: "tsp", name: "sea salt", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 2.0, measurement_unit: "T", name: "melted butter", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 3.0, measurement_unit: "whole", name: "egg", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 1.0, measurement_unit: "cup", name: "vanilla nut milk", preparation_style: '' },
  {recipe_id: recipe_85.id, quantity: 1.0, measurement_unit: "whole", name: "9\" pie crust", preparation_style: '' },
  {recipe_id: recipe_86.id, quantity: 4.0, measurement_unit: "cup", name: "water", preparation_style: "boiled and cooled" },
  {recipe_id: recipe_87.id, quantity: 4.0, measurement_unit: "whole", name: "sweet potato", preparation_style: "scrubbed" },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "lb", name: "chorizo", preparation_style: "casing removed and sliced into 1/2 moons" },
  {recipe_id: recipe_87.id, quantity: 0.5, measurement_unit: "cup", name: "vegetable stock", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "cup", name: "pumpkin puree", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "clove", name: "garlic", preparation_style: "minced" },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "whole", name: "chipotle in adobo sauce", preparation_style: "finely chopped, + 1 T sauce" },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "tsp", name: "orange zest", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "T", name: "honey", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 0.125, measurement_unit: "tsp", name: "ground nutmeg", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 1.0, measurement_unit: "cup", name: "shredded smoked cheddar cheese", preparation_style: '' },
  {recipe_id: recipe_87.id, quantity: 4.0, measurement_unit: "whole", name: "green onion", preparation_style: "chopped" },
  {recipe_id: recipe_88.id, quantity: 1.0, measurement_unit: "can", name: "beans", preparation_style: '' },
  {recipe_id: recipe_88.id, quantity: 2.0, measurement_unit: "stalk", name: "celery", preparation_style: '' }
])

meal_plan_43 = MealPlan.create!({ user_id: user.id, start_date: "2007-11-22", people_served: 4 })
meal_plan_42 = MealPlan.create!({ user_id: user.id, start_date: "2018-10-24", people_served: 2 })
meal_plan_44 = MealPlan.create!({ user_id: user.id, start_date: "2018-11-22", people_served: 2 })
meal_plan_39 = MealPlan.create!({ user_id: user.id, start_date: "2019-02-10", people_served: 2 })
meal_plan_37 = MealPlan.create!({ user_id: user.id, start_date: "2019-02-17", people_served: 2 })
meal_plan_40 = MealPlan.create!({ user_id: user.id, start_date: "2019-02-24", people_served: 2 })
meal_plan_41 = MealPlan.create!({ user_id: user.id, start_date: "2019-03-03", people_served: 2 })

MealPlanRecipe.create!([
  {meal_plan_id: meal_plan_37.id, recipe_id: recipe_68.id },
  {meal_plan_id: meal_plan_37.id, recipe_id: recipe_69.id },
  {meal_plan_id: meal_plan_37.id, recipe_id: recipe_72.id },
  {meal_plan_id: meal_plan_37.id, recipe_id: recipe_70.id },
  {meal_plan_id: meal_plan_37.id, recipe_id: recipe_71.id },
  {meal_plan_id: meal_plan_39.id, recipe_id: recipe_74.id },
  {meal_plan_id: meal_plan_39.id, recipe_id: recipe_73.id },
  {meal_plan_id: meal_plan_39.id, recipe_id: recipe_75.id },
  {meal_plan_id: meal_plan_39.id, recipe_id: recipe_51.id },
  {meal_plan_id: meal_plan_39.id, recipe_id: recipe_76.id },
  {meal_plan_id: meal_plan_40.id, recipe_id: recipe_64.id },
  {meal_plan_id: meal_plan_40.id, recipe_id: recipe_52.id },
  {meal_plan_id: meal_plan_40.id, recipe_id: recipe_77.id },
  {meal_plan_id: meal_plan_40.id, recipe_id: recipe_78.id },
  {meal_plan_id: meal_plan_40.id, recipe_id: recipe_79.id },
  {meal_plan_id: meal_plan_41.id, recipe_id: recipe_82.id },
  {meal_plan_id: meal_plan_41.id, recipe_id: recipe_81.id },
  {meal_plan_id: meal_plan_41.id, recipe_id: recipe_83.id },
  {meal_plan_id: meal_plan_41.id, recipe_id: recipe_84.id },
  {meal_plan_id: meal_plan_41.id, recipe_id: recipe_80.id },
  {meal_plan_id: meal_plan_42.id, recipe_id: recipe_86.id },
  {meal_plan_id: meal_plan_43.id, recipe_id: recipe_87.id },
  {meal_plan_id: meal_plan_44.id, recipe_id: recipe_68.id },
  {meal_plan_id: meal_plan_44.id, recipe_id: recipe_72.id}
])

# Shopping Lists
Aisle.create!([
  { user_id: user.id, name: 'Unassigned' },
  { user_id: user.id, name: 'produce: fruits' },
  { user_id: user.id, name: 'produce: greens' },
  { user_id: user.id, name: 'produce: peppers' },
  { user_id: user.id, name: 'produce: vegetables' },
  { user_id: user.id, name: 'produce: potatoes & roots' },
  { user_id: user.id, name: 'bread & tortillas' },
])

shopping_list = user.shopping_lists.create(name: 'grocery')

ShoppingListItem.create!([
  { aisle_id: user.aisles.first.id, quantity: 2, name: 'apple' },
  { aisle_id: user.aisles.first.id, quantity: 1, name: 'blueberries' },
  { aisle_id: user.aisles.second.id, quantity: 1, name: 'salad greens' },
  { aisle_id: user.aisles.second.id, quantity: 1, name: 'bulb of fennel' },
])
