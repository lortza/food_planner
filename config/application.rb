require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FoodPlanner
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Configuration for the application, engines, and railties goes here
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # config.time_zone = "Central Time (US & Canada)"
    # Don't generate system test files.
    config.generators.system_tests = nil
    # config.eager_load_paths << Rails.root.join("extras")

    Raven.configure do |config|
      config.dsn = Rails.application.credentials.sentry_raven_dsn
      config.environments = %w[ production ]
    end
  end
end
