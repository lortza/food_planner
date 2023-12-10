Sentry.init do |config|
  config.dsn = Rails.application.credentials.sentry_dsn
  config.enabled_environments = %w[ production ]
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # To activate performance monitoring, set one of these options.

  # Set a uniform sample rate between 0.0 and 1.0
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0

  # or control sampling dynamically
  # config.traces_sampler = lambda do |sampling_context|
  #   sampling_context[:transaction_context] # contains the information about the transaction
  #   sampling_context[:parent_sampled] # contains the transaction's parent's sample decision
  #   true # return value can be a boolean or a float between 0.0 and 1.0
  # end
end