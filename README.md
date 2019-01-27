# Food Planner

WIP food planning app.

* Ruby 2.5.0
* Rails 5.2
* Postgres
* RuboCop
* RSpec

## Features

* List of recipes & ingredients
* Display full recipes
* Display ingredient breakdown for meal prep

## Getting Started

* Fork & Clone
* Bundle
* rake db setup
* rake db seed
* run RuboCop: `rubocop`
* run tests: `bundle exec rspec`

## WIP Notes:
`MealPlan` is in the process of being replaced by `Preparation`. But `Preparation` feels like a trainwreck because it seems like I'm doing a lot of work messing around with preparations just to get dates -- and then to get the related recipes. The `MealPlan` approach made this more straightforward and didn't seem like it was reaching beyond its own scope.
