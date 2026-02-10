# Food Planner

[![Maintainability](https://api.codeclimate.com/v1/badges/bce541f2a6d63bc5fa1e/maintainability)](https://codeclimate.com/github/lortza/food_planner/maintainability)

WIP food planning app.

Live on heroku as [myfoodplanner](http://myfoodplanner.herokuapp.com)

- Ruby
- Rails
- Postgres
- [Standard (Ruby)](https://github.com/standardrb/standard), which supports the [VSCode extension](https://github.com/standardrb/vscode-standard-ruby)
- RSpec
- [Bootstrap 4.1.3](https://getbootstrap.com/docs/4.6/getting-started/introduction/)
- [Material Icons](https://fonts.google.com/icons)

* [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager

## Features

- List of recipes & ingredients
- Display full recipes
- Display ingredient breakdown for meal prep
- Add recipes to meal plan for the week
- Current week meal plan in nav bar
- AI-driven recipe parsing for adding new recipes
- Add recipe items to grocery list from recipe or meal plan
- ERD https://dbdiagram.io/d/5d6ea192ced98361d6de29cd

## Getting Started

- Fork & Clone
- `bundle`
- Set up DB: `rake db:setup` (Runs `db:create`, `db:schema:load` and `db:seed`)
- User: In development, see the seeds file for the user credentials so you can log in
- Run `rails s` to start the server

## Standard RB

Standard RB is used for enforcing style guide

- Run with: `standardrb` or `standardrb --fix`

## Tests

- Tests: `bundle exec rspec`

### Linters

This project uses these linters in CI:

- [reek](https://github.com/troessner/reek)
- [standard](https://github.com/standardrb/standard)
- [scss-lint](https://github.com/sds/scss-lint)

Run them locally on your machine like this:

```
bundle exec reek

bundle exec scss-lint app/assets/stylesheets/**.scss

standardrb --fix
# or
rake standard:fix
```

## Related Docs

- [Devise](https://github.com/plataformatec/devise)
- [Uglifier](https://github.com/lautis/uglifier) in harmony mode
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)

## Heroku Scheduler

Heroku runs a cron job to add the weekly shopping_list items to the grocery list. This is accomplished with a rake task plus the cron job. The job is set to run daily because heroku doesn't offer a weekly interval. The rake task has a condition to only allow it to run on a specific day of the week. [Configure the cron job](https://dashboard.heroku.com/apps/myfoodplanner/scheduler).

This feature is dependent on my account having both a list named "grocery" and another list named "weekly items." Without either of those specifically-named lists, this job will error.

## Editing the credentials file

Never open the `master.key` or `credentials.yml.enc` in atom. This will add newline characters that you can't remove and it will not be able to be unencrypted.

To edit this file, run:

```
EDITOR="code --wait" bin/rails credentials:edit
```

If this file gets borked, [this post](https://stackoverflow.com/a/54279636/5009528) and [this post](https://medium.com/@kirill_shevch/encrypted-secrets-credentials-in-rails-6-rails-5-1-5-2-f470accd62fc) will help.

## Deploying

- log into Heroku CLI with `heroku login`
- assuming your local copy of the `main` branch is up to date, run `git push heroku main`

## WIP USDA Food Composition Databases

- API docs: https://ndb.nal.usda.gov/ndb/doc/index
- Ex Food show page: https://ndb.nal.usda.gov/ndb/foods/show/01009?fgcd=&manu=&format=&count=&max=25&offset=&sort=default&order=asc&qlookup=01009&ds=&qt=&qp=&qa=&qn=&q=&ing=
- Ex Nutrient show page: https://ndb.nal.usda.gov/ndb/nutrients/report/nutrientsfrm?max=25&offset=0&totCount=0&nutrient1=324&nutrient2=&subset=0&sort=c&measureby=g
