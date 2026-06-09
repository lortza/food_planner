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
  DEFAULT_MAX_TOKENS = 1024
  OPUS_MODEL_ID = "claude-opus-4-7"
  SONNET_MODEL_ID = "claude-sonnet-4-6"

  class << self
    def create_message(prompt:, model: SONNET_MODEL_ID, max_tokens: DEFAULT_MAX_TOKENS)
      post_message(
        model: model,
        max_tokens: max_tokens,
        messages: [{
          role: "user",
          content: prompt
        }]
      )
    end

    # Sends an image alongside a text prompt using Anthropic's vision content
    # blocks. The image block comes first (Anthropic's recommended ordering),
    # followed by the text instructions. image_data must be base64 and
    # media_type one of the Anthropic-supported image mime types.
    def create_message_with_image(prompt:, image_data:, media_type:, model: SONNET_MODEL_ID, max_tokens: DEFAULT_MAX_TOKENS)
      post_message(
        model: model,
        max_tokens: max_tokens,
        messages: [{
          role: "user",
          content: [
            {type: "image", source: {type: "base64", media_type: media_type, data: image_data}},
            {type: "text", text: prompt}
          ]
        }]
      )
    end

    private

    def post_message(body)
      response = HTTParty.post(
        "#{BASE_URL}/messages",
        headers: {
          "x-api-key" => Rails.application.credentials.anthropic_api_key,
          "anthropic-version" => "2023-06-01",
          "content-type" => "application/json"
        },
        body: body.to_json
      )

      puts response.parsed_response
      handle_response(response)
    end

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
