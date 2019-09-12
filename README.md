# Food Planner

[![CircleCI](https://circleci.com/gh/lortza/food_planner.svg?style=svg)](https://circleci.com/gh/lortza/food_planner)

# CodeClimate Quality Badge
[![Maintainability](https://api.codeclimate.com/v1/badges/bce541f2a6d63bc5fa1e/maintainability)](https://codeclimate.com/github/lortza/food_planner/maintainability)

WIP food planning app.

Live on heroku as [myfoodplanner](http://myfoodplanner.herokuapp.com)

* Ruby 2.5.3
* Rails 5.2
* Postgres
* RuboCop
* RSpec
- [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager

## Features

* List of recipes & ingredients
* Display full recipes
* Display ingredient breakdown for meal prep
* ERD https://dbdiagram.io/d/5d6ea192ced98361d6de29cd

## Getting Started

* Fork & Clone
* Bundle
* `rake db:setup`
* `rake db:seed`
* run RuboCop: `rubocop`
* run tests: `bundle exec rspec`

### Linters
This project uses these linters in CI:
* [reek](https://github.com/troessner/reek)
* [rubocop](https://github.com/rubocop-hq/rubocop)
* [scss-lint](https://github.com/sds/scss-lint)

Run them locally on your machine like this:
```
bundle exec reek

bundle exec rubocop

bundle exec scss-lint app/assets/stylesheets/**.scss
```

## Related Docs
* [Devise](https://github.com/plataformatec/devise)
* [Uglifier](https://github.com/lautis/uglifier) in harmony mode
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)

## Heroku Scheduler
Heroku runs a cron job to add the weekly shopping_list items to the grocery list. This is accomplished with a rake task plus the cron job. The job is set to run daily because heroku doesn't offer a weekly interval. The rake task has a condition to only allow it to run on a specific day of the week. [Configure the cron job](https://dashboard.heroku.com/apps/myfoodplanner/scheduler).

This feature is dependent on my account having both a list named "grocery" and another list named "weekly items." Without either of those specifically-named lists, this job will error.

## WIP Notes:



## USDA Food Composition Databases

- API docs: https://ndb.nal.usda.gov/ndb/doc/index
- Ex Food show page: https://ndb.nal.usda.gov/ndb/foods/show/01009?fgcd=&manu=&format=&count=&max=25&offset=&sort=default&order=asc&qlookup=01009&ds=&qt=&qp=&qa=&qn=&q=&ing=
- Ex Nutrient show page: https://ndb.nal.usda.gov/ndb/nutrients/report/nutrientsfrm?max=25&offset=0&totCount=0&nutrient1=324&nutrient2=&subset=0&sort=c&measureby=g
