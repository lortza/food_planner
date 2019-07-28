# Food Planner

[![Build Status](https://travis-ci.com/lortza/sorrygirl.svg?branch=master)](https://travis-ci.com/lortza/food_planner)

[![Maintainability](https://api.codeclimate.com/v1/badges/bce541f2a6d63bc5fa1e/maintainability)](https://codeclimate.com/github/lortza/food_planner/maintainability)

WIP food planning app.

Live on heroku as [myfoodplanner](http://myfoodplanner.herokuapp.com)

* Ruby 2.5.3
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
* `rake db:setup`
* `rake db:seed`
* run RuboCop: `rubocop`
* run tests: `bundle exec rspec`

### Linters
This project uses [rubocop](https://github.com/rubocop-hq/rubocop) and [scss-lint](https://github.com/sds/scss-lint). Run them locally on your machine like this:
```
bundle exec rubocop

bundle exec scss-lint app/assets/stylesheets/**.scss
```

## Related Docs
* [Devise](https://github.com/plataformatec/devise)
* [Uglifier](https://github.com/lautis/uglifier) in harmony mode
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)

## WIP Notes:



## USDA Food Composition Databases

- API docs: https://ndb.nal.usda.gov/ndb/doc/index
- Ex Food show page: https://ndb.nal.usda.gov/ndb/foods/show/01009?fgcd=&manu=&format=&count=&max=25&offset=&sort=default&order=asc&qlookup=01009&ds=&qt=&qp=&qa=&qn=&q=&ing=
- Ex Nutrient show page: https://ndb.nal.usda.gov/ndb/nutrients/report/nutrientsfrm?max=25&offset=0&totCount=0&nutrient1=324&nutrient2=&subset=0&sort=c&measureby=g
