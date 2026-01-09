# frozen_string_literal: true

class ApiNinjaClient
  # Nutrition API docs https://api-ninjas.com/api/nutrition

  # Sample response:
  # [
  #   {
  #       "name": "chicken",
  #       "calories": "Only available for premium subscribers.",
  #       "serving_size_g": 1360.7759999999998,
  #       "fat_total_g": 175.5,
  #       "fat_saturated_g": 49.8,
  #       "protein_g": "Only available for premium subscribers.",
  #       "sodium_mg": 983,
  #       "potassium_mg": 2437,
  #       "cholesterol_mg": 1253,
  #       "carbohydrates_total_g": 0.6,
  #       "fiber_g": 0.0,
  #       "sugar_g": 0.0
  #   },
  # ]

  require "httparty"
  BASE_URL = "https://api.api-ninjas.com/v1"

  class << self
    def get_nutrition_from_freeform(query)
      encoded_query = encode_query(query)
      response = HTTParty.get(
        "#{BASE_URL}/nutrition",
        headers: {
          "X-Api-Key" => Rails.application.credentials.api_ninja_key
        },
        query: {
          query: encoded_query
        },
        format: :json,
        parser: ->(body, format) { JSON.parse(body, symbolize_names: true) }
      )
      puts response.parsed_response
      handle_response(response)
    end

    private

    def encode_query(query)
      query.gsub(",", "%2C")
    end

    def handle_response(response)
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
