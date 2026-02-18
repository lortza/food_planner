# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip
gem "rails", "~> 7.2.2.2"         # Updates to the latest patch that's lower than 7.2

gem "bootsnap", ">= 1.1.0", require: false # Reduces boot times through caching; required in config/boot.rb
gem "coffee-rails"              # Use CoffeeScript for .coffee assets and views
gem "devise"                    # User authentication
gem "httparty"                  # Makes HTTP requests easier
gem "jbuilder", "~> 2.14"       # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "loofah", ">= 2.2.3"        # Upgrade for security update
gem "nokogiri", ">= 1.8.5"      # Upgrade for security update
gem "pg", ">= 0.18", "< 2.0"
gem "puma"                      # Use Puma as the app server
gem "pundit"                    # Authorization
gem "rack", ">= 2.0.6"          # Upgrade for security update
gem "sprockets-rails"           # Asset pipeline for Rails
gem "sentry-rails"              # Rails support for Sentry
gem "sentry-ruby"               # Error reporting to Sentry.io
gem "will_paginate", "~> 4.0.1" # pagination. Styles: http://mislav.github.io/will_paginate/
# gem 'redis', '~> 4.0'           # Use Redis adapter to run Action Cable in production
# gem 'mini_magick', '~> 4.8'     # Use ActiveStorage variant
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment
gem "net-imap", require: false
gem "net-pop", require: false
gem "net-smtp", require: false  # Send internet mail via SMTP
gem "commonmarker"                # Fast, safe and extensible Markdown parser in Ruby using the cmark library

group :development do
  gem "annotate"
  gem "awesome_print"
  gem "bullet"                      # detects n+1 queries
  gem "listen"
  # gem 'magic_frozen_string_literal'
  gem "rails-erd", require: false   # generates table diagram run `bundle exec erd`
  gem "standard"                    # standard rb code linter
  gem "erb_lint"                    # erb code linter
  gem "rubycritic", require: false  # provides stats on code build
  gem "seed_dump"                   # invoke with `rake db:seed:dump`
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.1.0"
  gem "web-console", ">= 3.3.0"     # Access an IRB console by using <%= console %> anywhere in the code.
end

group :development, :test do
  gem "better_errors"           # creates console in browser for errors
  gem "binding_of_caller"       # goes with better_errors
  gem "byebug", platforms: %i[mri windows] # Call 'byebug' anywhere in the code to get a debugger console
  gem "factory_bot_rails"       # factory support for rspec
  gem "faker"                   # Fake data for factories
  gem "guard-rspec", require: false # runs rspec automatically
  gem "pry-rails"               # helps with pry
  gem "reek"                    # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
  gem "rspec-rails", "~> 8.0.3"
  gem "selenium-webdriver"
end

group :test do
  gem "capybara"                  # for navigating feature specs
  # gem 'database_cleaner-active_record'
  gem "launchy"                   # open browser with save_and_open_page
  gem "rails-controller-testing"  # allows for controller testing
  gem "shoulda-matchers"          # library for easier testing syntax
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]
