# frozen_string_literal: true

require "uri"

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    # Attempt to parse the value as a URI
    uri = URI.parse(value)

    # Check if the scheme is http or https (optional, but often necessary for URLs)
    unless %w[http https].include?(uri.scheme)
      record.errors.add(attribute, :invalid_scheme, options.except(:scheme))
    end

    # Check if a host is present
    if uri.host.blank?
      record.errors.add(attribute, :invalid_host, options.except(:host))
    end

  # Rescue the InvalidURIError exception if parsing fails
  rescue URI::InvalidURIError
    record.errors.add(attribute, :invalid, options.except(:message))
  end
end
