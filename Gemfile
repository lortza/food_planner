# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'bootsnap', '>= 1.1.0', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'coffee-rails'              # Use CoffeeScript for .coffee assets and views
gem 'devise'                    # User authentication
gem 'jbuilder', '~> 2.5'        # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'loofah', '>= 2.2.3'        # Upgrade for security update
gem 'nokogiri', '>= 1.8.5'      # Upgrade for security update
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.2'            # Use Puma as the app server
gem 'rack', '>= 2.0.6'          # Upgrade for security update
gem 'rails', '~> 6.0.0'         # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'sass-rails', '~> 6.0'      # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'      # Use Uglifier as compressor for JavaScript assets
# gem 'redis', '~> 4.0'           # Use Redis adapter to run Action Cable in production
# gem 'mini_magick', '~> 4.8'  # Use ActiveStorage variant
# gem 'capistrano-rails', group: :development # Use Capistrano for deployment

group :development, :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
  gem 'better_errors'           # creates console in browser for errors
  gem 'binding_of_caller'       # goes with better_errors
  gem 'bullet'                  # detects n+1 queries
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Call 'byebug' anywhere in the code to get a debugger console
  gem 'pry-rails'
  gem 'reek'                    # https://github.com/troessner/reek/blob/master/docs/Code-Smells.md
end

group :development do
  gem 'awesome_print'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'magic_frozen_string_literal'
  gem 'rails-erd', require: false   # generates table diagram run `bundle exec erd`
  gem 'rubycritic', require: false  # provides stats on code build
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'scss_lint', require: false # css linter
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # Access an IRB console by using <%= console %> anywhere in the code.
end

group :test do
  gem 'factory_bot_rails'       # factory support for rspec
  gem 'launchy'                 # open browser with save_and_open_page
  gem 'shoulda-matchers'        # library for easier testing syntax
  gem 'webdrivers'              # to help with testing
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
