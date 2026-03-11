# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").strip
gem "rails", "~> 7.2.3"         # Updates to the latest patch that's lower than 7.2

gem "sprockets-rails"           # Asset pipeline for Rails
gem "pg", ">= 0.18", "< 2.0"    # Use PostgreSQL as the database for Active Record
gem "puma"                      # Use Puma as the app server
gem "importmap-rails"           # Use Importmap for JavaScript management
gem "turbo-rails"               # Use Turbo for faster page loads and interactivity https://turbo.hotwired.dev
gem "stimulus-rails"            # Use Stimulus for JavaScript behavior https://stimulus.hotwired.dev
gem "jbuilder"                  # Build JSON APIs with ease. https://github.com/rails/jbuilder
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "devise"                    # User authentication
gem "httparty"                  # Makes HTTP requests easier
gem "loofah", ">= 2.2.3"        # HTML, XML, SAX, and Reader parser. Loofah depends on Nokogiri.
gem "nokogiri", ">= 1.8.5"      # HTML, XML, SAX, and Reader parser. Loofah depends on Nokogiri.
gem "pundit"                    # Authorization
gem "sentry-rails"              # Rails support for Sentry
gem "sentry-ruby"               # Error reporting to Sentry.io
gem "will_paginate", "~> 4.0.1" # pagination. Styles: http://mislav.github.io/will_paginate/

gem "commonmarker"                # Fast, safe and extensible Markdown parser in Ruby using the cmark library

group :development do
  gem "annotate"
  gem "bullet"                      # detects n+1 queries
  # gem 'magic_frozen_string_literal'. # Automatically adds `# frozen_string_literal: true` to new Ruby files. Run `bundle exec magic_frozen_string_literal --help` for more info.
  gem "rails-erd", require: false   # generates table diagram run `bundle exec erd`
  gem "standard"                    # standard rb code linter
  gem "erb_lint"                    # erb code linter
  gem "rubycritic", require: false  # provides stats on code build
  gem "seed_dump"                   # invoke with `rake db:seed:dump`
  gem "web-console"                 # Access an IRB console by using <%= console %> anywhere in the code.
end

group :development, :test do
  gem "brakeman", require: false # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "better_errors"           # creates console in browser for errors
  gem "binding_of_caller"       # goes with better_errors
  gem "byebug", platforms: %i[mri windows] # Call 'byebug' anywhere in the code to get a debugger console
  gem "factory_bot_rails"       # factory support for rspec
  gem "faker"                   # Fake data for factories
  gem "guard-rspec", require: false # runs rspec automatically
  gem "pry-rails"               # helps with pry
  gem "reek"                    # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
end

group :test do
  gem "rspec-rails", "~> 8.0.2"
  gem "rails-controller-testing"  # allows for controller testing
  gem "shoulda-matchers"          # library for easier testing syntax
  gem "selenium-webdriver"
  gem "capybara"                  # for navigating feature specs
  # gem 'database_cleaner-active_record'
  gem "launchy"                   # open browser with save_and_open_page
end
