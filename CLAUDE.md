# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Food Planner is a Rails 7 application for meal planning, recipe management, and grocery shopping list organization. It helps users plan meals, track recipes with ingredients, generate shopping lists organized by store aisles, and manage meal prep schedules.

**Tech Stack:**
- Ruby 3.3.10
- Rails 7.2.2.2
- PostgreSQL
- Bootstrap 5.3.3
- Plain CSS with CSS custom properties (no SASS/SCSS)
- Vanilla JavaScript (no jQuery)
- RSpec for testing
- Standard RB for linting
- Devise for authentication
- Pundit for authorization

**Live Site:** http://myfoodplanner.herokuapp.com

## Development Commands

### Setup
```bash
bundle
rake db:setup  # Runs db:create, db:schema:load, and db:seed
rails s        # Start server
```

**Seeds:** Development user credentials are `admin@email.com` / `password` (see db/seeds.rb)

### Testing
```bash
bundle exec rspec                    # Run all tests
bundle exec rspec spec/models/       # Run model tests only
bundle exec rspec spec/path/to/file_spec.rb  # Run single test file
bundle exec rspec spec/path/to/file_spec.rb:42  # Run single test at line 42
```

### Linting
```bash
standardrb              # Check Ruby style
standardrb --fix        # Auto-fix Ruby style issues
rake standard:fix       # Alternative auto-fix command
bundle exec reek        # Check code smells
bundle exec erblint --lint-all  # Check ERB templates
```

### Database
```bash
rake db:migrate
rake db:rollback
bundle exec erd         # Generate ERD diagram (creates erd.pdf)
rake db:seed:dump       # Export current data to seeds format
```

### Credentials Management
```bash
EDITOR="code --wait" bin/rails credentials:edit
```

**IMPORTANT:** Never open `master.key` or `credentials.yml.enc` in Atom or other editors that add newlines - this will corrupt the file. Always use the command above with VSCode or another editor that respects `--wait`.

### Deployment
```bash
heroku login
git push heroku main    # Deploy to Heroku
```

## Architecture

### Core Domain Models

**Recipe** - Central model representing a recipe with ingredients, cooking instructions, and prep day instructions
- Belongs to User
- Has many Ingredients (with nested attributes support)
- Has many MealPlans through MealPlanRecipes
- Has many Tags through RecipeTags
- Three statuses: `pending`, `active`, `archived`
- Tracks prep_time, cook_time, reheat_time, servings
- Validates that at least one time field (prep/cook/reheat) is non-zero
- Implements prep day workflow with separate `prep_day_instructions` and `reheat_instructions`
- Key method: `dupe_for_user(user)` for copying recipes between users

**MealPlan** - Represents a specific day's meal preparation
- Has many Recipes through MealPlanRecipes
- Associates a preparation date (`prepared_on`) with multiple recipes
- Calculates total prep time, cook time, servings, and estimated completion time
- Uses `EFFICIENCY_RATE` (0.66) to account for parallel cooking tasks
- Calculates `recommended_start_time` based on 5:00 PM end time goal
- Key scopes: `future`, `upcoming`, `by_date`, `most_recent_first`
- Class method `suggested_date(user)` intelligently suggests next meal prep date (defaults to upcoming Sunday)

**ShoppingList** - Manages shopping lists organized by aisles
- Has many ShoppingListItems
- Has many ScheduledDeliveries
- One list per user is marked as `main` (default list)
- Lists can be marked as `favorite` for quick access
- Search functionality for items via `search_results(terms)`

**Ingredient** - Represents an ingredient within a recipe
- Belongs to Recipe and Aisle
- Tracks name, quantity, unit, recipe_section
- Organized by aisles for grocery shopping workflow

**Aisle** - Represents physical store aisle locations
- Used to organize ingredients and shopping list items
- Each user gets default aisles created via `UserDataSetup` service
- Aisles have `order_number` for sorting in store walking order

### Key Service Objects

**UserDataSetup** (`app/services/user_data_setup.rb`)
- Runs when new users are created
- Creates default shopping list named "grocery" (marked as main)
- Populates ~45 default aisles matching a specific store layout
- Creates default empty Inventory
- Call with `UserDataSetup.setup(user)`

**IngredientSet**
- Builds consolidated ingredient lists from meal plans
- Groups ingredients by name and aisle for shopping

**RecipeDataExtractor** / **Scraper**
- Extract recipe data from external websites
- Parse structured recipe information

**NutritionCalculator** (WIP service in app/services/)
- Likely handles nutritional information calculations

### Authorization with Pundit

All resources use Pundit policies in `app/policies/`:
- `RecipePolicy`, `MealPlanPolicy`, `ShoppingListPolicy`, `AislePolicy`, etc.
- Policies scope resources to current user
- Standard pattern: users can only access their own resources

### Searchable Concern

The `Searchable` module (`app/models/concerns/searchable.rb`) is extended by models that need search/sort capabilities:
- `search(field:, terms:)` - Case-insensitive ILIKE search
- `by_name`, `by_title`, `by_id` - Common sorting scopes

## Important Patterns

### Recipe Status Workflow
Recipes have three states:
1. **pending** - Incomplete recipes, minimal validation, allows saving in-progress work
2. **active** - Complete recipes, full validation enforced, appears in main recipe lists
3. **archived** - Hidden from active use but preserved

Pending recipes skip most validations, allowing users to save incomplete recipe data before finalizing.

### Instructions Duplication
Recipes store both `instructions` (eating day) and `prep_day_instructions` (prep day). The callback `guarantee_instructions_values` ensures both are populated - if one is blank, it copies from the other.

### Nested Attributes
Recipe form uses `accepts_nested_attributes_for :ingredients` with:
- `reject_if: :all_blank` - Ignores empty ingredient rows
- `allow_destroy: true` - Checkbox deletion support

### Single Table Inheritance Note
Models use concerns for shared behavior rather than STI.

## Testing Patterns

- FactoryBot factories defined in `spec/factories/`
- Shoulda Matchers for model testing
- Capybara for feature tests
- Request specs for controller testing
- RSpec configuration in `spec/rails_helper.rb` and `spec/spec_helper.rb`
- Pundit RSpec matchers available for policy testing

## Heroku Scheduler Integration

The app uses Heroku Scheduler to run cron jobs (see README):
- Adds weekly shopping list items to the grocery list
- Rake tasks in `lib/tasks/shopping_list_tasks.rake`
- Configured to run daily with day-of-week check
- **Requires** lists named "grocery" and "weekly items" to exist

## Custom Rake Tasks

Located in `lib/tasks/`:
- `recipe_tasks.rake` - Recipe-related operations
- `shopping_list_tasks.rake` - Shopping list automation (used by Heroku scheduler)
- `unit_change_tasks.rake` - Ingredient unit conversions
- `data/` - Data migration tasks
- `auto_annotate_models.rake` - Auto-updates schema comments in model files

## Routes Notes

- Root path: `shopping_lists#show` (default shopping list)
- User sign-up is currently disabled (empty path)
- Registrations controller exists but is commented out for when sign-ups are re-enabled
- Member routes for `meal_plans`: `copy`, `prep_day`
- Shopping list item status management has custom routes (activate, deactivate, add_to_cart, etc.)
- Route refactoring TODO: Shopping list item status routes should use `member do` blocks

## Styling & Assets

**CSS Architecture:**
- All styles use plain CSS (no SASS/SCSS preprocessor)
- CSS custom properties defined in `app/assets/stylesheets/variables.css`
- Variables use `--variable-name` syntax and accessed via `var(--variable-name)`
- Sprockets asset pipeline for compilation
- Bootstrap 5.3.3 loaded via CDN in layout

**JavaScript:**
- Vanilla JavaScript only (no jQuery)
- Custom scripts in `app/assets/javascripts/`
- Bootstrap 5 components work without jQuery dependency

**Key Utility Classes:**
- Custom utilities in `app/assets/stylesheets/utilities.css`
- Includes flexbox, spacing, cursor, and form helpers
- `.container-navbar-padding` provides consistent horizontal spacing

## CI/CD

GitHub Actions workflow: `.github/workflows/rubyonrails.yml`
- Runs on PRs
- Linters: reek, standard
- Tests: RSpec suite
