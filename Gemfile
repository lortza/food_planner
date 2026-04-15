# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.3"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use PostgreSQL as the database for Active Record
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache" # https://github.com/rails/solid_cache
gem "solid_queue" # https://github.com/rails/solid_queue
gem "solid_cable" # https://github.com/rails/solid_cable

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2" # Uses gem mini_magick as a dependency to process images sizes

# Authentication and Authorization
gem "devise"                    # User authentication
gem "pundit"                    # Authorization

# Error Reporting
gem "sentry-rails"              # Rails support for Sentry
gem "sentry-ruby"               # Error reporting to Sentry.io

# HTTP Requests & Web scraping
gem "requestjs-rails"           # JS library for making HTTP requests in Stimulus. https://github.com/rails/requestjs-rails
gem "httparty"                  # Makes HTTP requests easier
gem "nokogiri", ">= 1.8.5"      # HTML, XML, SAX, and Reader parser. Loofah depends on Nokogiri.

# HTML helpers
gem "will_paginate", "~> 4.0.1" # pagination. Styles: http://mislav.github.io/will_paginate/
gem "commonmarker"                # Fast, safe and extensible Markdown parser in Ruby using the cmark library

group :development do
  gem "annot8"                      # Annotate models, routes, etc. Run `bundle exec annotate` to add annotations. https://github.com/chemica/annotate_models
  gem "bullet"                      # detects n+1 queries
  # gem 'magic_frozen_string_literal'. # Automatically adds `# frozen_string_literal: true` to new Ruby files. Run `bundle exec magic_frozen_string_literal --help` for more info.
  gem "rails-erd", require: false   # generates table diagram run `bundle exec erd`
  gem "standard"                    # standard rb code linter
  gem "erb_lint"                    # erb code linter
  gem "reek"                        # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
  gem "rubycritic", require: false  # provides stats on code build
  gem "seed_dump"                   # invoke with `rake db:seed:dump`
  gem "web-console"                 # Access an IRB console by using <%= console %> anywhere in the code.
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Audits gems for known security defects (use config/bundler-audit.yml to ignore issues)
  gem "bundler-audit", require: false

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  gem "better_errors"           # creates console in browser for errors
  gem "binding_of_caller"       # goes with better_errors
  gem "factory_bot_rails"       # factory support for rspec
  gem "faker"                   # Fake data for factories
  gem "guard-rspec", require: false # runs rspec automatically
  gem "pry-rails"               # helps with pry
end

group :test do
  gem "capybara"                  # for navigating feature specs
  gem "selenium-webdriver"
  gem "rspec-rails"               # testing framework. Run `rails generate rspec:install` to get started.
  gem "rails-controller-testing"  # allows for controller testing
  gem "shoulda-matchers"          # library for easier testing syntax
  # gem 'database_cleaner-active_record'
  gem "launchy"                   # open browser with save_and_open_page
end
