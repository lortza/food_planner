# Food Planner

[![Maintainability](https://api.codeclimate.com/v1/badges/bce541f2a6d63bc5fa1e/maintainability)](https://codeclimate.com/github/lortza/food_planner/maintainability)

WIP food planning app.

Live on heroku as [myfoodplanner](http://myfoodplanner.herokuapp.com)

- Ruby
- Rails
- Postgres
- [Standard (Ruby)](https://github.com/standardrb/standard), which supports the [VSCode extension](https://github.com/standardrb/vscode-standard-ruby)
- RSpec
- [Bootstrap 5.3.3](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
- [Material Icons](https://fonts.google.com/icons)
- Plain CSS (no SASS/SCSS)
- Vanilla JavaScript (no jQuery)

* [Dependabot](https://app.dependabot.com/accounts/lortza/) dependency manager

## Features

- List of recipes & ingredients
- Display full recipes
- Display ingredient breakdown for meal prep
- Display page of all meal plan recipes for prep day. Check off ingredients and steps for each recipe. Toggle off a recipe when it is complete.
- ERD https://dbdiagram.io/d/5d6ea192ced98361d6de29cd
- Favorite a shopping list to have it appear at the top of the lists page
- Mark items as arriving with upcoming delivery order
- Toggle items on/off the shopping list
- Upcoming meal plan displayed in nav bar (if present)
- Create a recipe from scratch or create one via a source url and AI parsing
- Archive recipes you no longer care to see in your list
- Share a recipe with a friend
- Add recurring items to your shopping list with a cadence of weekly, biweekly, or monthly
- Separate notes section to keep your favorite conversions or other things you may need to jot down that aren't related to one specific recipe.
- Mark a note as "favorite" for it to appear in in the Notes dropdown.
- Copy a whole meal plan to reuse it easily.


## Getting Started
- Fork & Clone
- `bundle`
- Set up DB: `rake db:setup` (Runs `db:create`, `db:schema:load` and `db:seed`)
- User: In development, see the seeds file for the user credentials so you can log in
- Run `rails s` to start the server

## Linting

### Ruby
Standard RB is used for enforcing Ruby style guide:
```bash
standardrb
standardrb --fix
# or
rake standard:fix
```

## Tests

- Tests: `bundle exec rspec`

### Code Quality Tools

This project uses these tools in CI:

- [reek](https://github.com/troessner/reek) - Code smell detection
- [standard](https://github.com/standardrb/standard) - Ruby style guide

Run them locally:
```bash
bundle exec reek
```

## Related Docs

- [Devise](https://github.com/plataformatec/devise)
- [Uglifier](https://github.com/lautis/uglifier) in harmony mode
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers)

## Heroku Scheduler

Heroku runs a cron job to add the weekly shopping_list items to the grocery list. This is accomplished with a rake task plus the cron job. The job is set to run daily because heroku doesn't offer a weekly interval. The rake task has a condition to only allow it to run on a specific day of the week. [Configure the cron job](https://dashboard.heroku.com/apps/myfoodplanner/scheduler).

This feature is dependent on my account having both a list named "grocery" and another list named "weekly items." Without either of those specifically-named lists, this job will error.

## Solid Trio Implementation
The Solid Trio (`solid_cache`, `solid_cable`, `solid_queue`) are implemented as tables in the main database instead of separate tables. https://guides.rubyonrails.org/8_0_release_notes.html

## Managing External libraries
* Bootstrap JS is pinned in the importmap
* Bootstrap CSS is a CDN link in the HTML

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
