# frozen_string_literal: true

class AnthropicApiClient
  # Claude AI API docs https://docs.claude.com/en/api/overview
  #
  # Sample response:
  # {"model"=>"claude-sonnet-4-5-20250929",
  #  "id"=>"msg_013M1V4y6xHurZisDh",
  #  "type"=>"message",
  #  "role"=>"assistant",
  #  "content"=>[{"type"=>"text", "text"=>"site_blocked"}],
  #  "stop_reason"=>"end_turn",
  #  "stop_sequence"=>nil,
  #  "usage"=>
  #   {"input_tokens"=>284,
  #    "cache_creation_input_tokens"=>0,
  #    "cache_read_input_tokens"=>0,
  #    "cache_creation"=>{"ephemeral_5m_input_tokens"=>0, "ephemeral_1h_input_tokens"=>0},
  #    "output_tokens"=>6,
  #    "service_tier"=>"standard"}}

  require "httparty"
  BASE_URL = "https://api.anthropic.com/v1"

  class << self
    def create_message(prompt:, model: "claude-sonnet-4-5", max_tokens: 1024)
      response = HTTParty.post(
        "#{BASE_URL}/messages",
        headers: {
          "x-api-key" => Rails.application.credentials.anthropic_api_key,
          "anthropic-version" => "2023-06-01",
          "content-type" => "application/json"
        },
        body: {
          model: model,
          max_tokens: max_tokens,
          messages: [{role: "user", content: prompt}]
        }.to_json
      )

      puts response.parsed_response
      handle_response(response)
    end

    private

    def handle_response(response)
      # When response has "type": "error" https://docs.claude.com/en/api/errors
      case response.code
      when 200..299
        response.parsed_response
      when 400
        raise BadRequestError, response.body
      when 401
        raise UnauthorizedError, "Invalid API key"
      when 429
        raise RateLimitError, "Rate limit exceeded"
      when 500..599
        raise ServerError, "Server error: #{response.code}"
      else
        raise APIError, "Unexpected error: #{response.code}"
      end
    end
  end
end

class APIError < StandardError; end
class BadRequestError < APIError; end
class UnauthorizedError < APIError; end
class RateLimitError < APIError; end
class ServerError < APIError; end
