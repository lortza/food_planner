# frozen_string_literal: true

class UsdaFoodDataCentralApiClient
  # API Guide https://fdc.nal.usda.gov/api-guide
  # Docs https://fdc.nal.usda.gov/api-spec/fdc_api.html
  # Swagger Docs: https://app.swaggerhub.com/apis/fdcnal/food-data_central_api/1.0.1#/FDC/getFoodsSearch

  # Sample response:
  # {
  #     "totalHits": 68,
  #     "currentPage": 1,
  #     "totalPages": 2,
  #     "pageList": [
  #         1,
  #         2
  #     ],
  #     "foodSearchCriteria": {
  #         "dataType": [
  #             "Foundation"
  #         ],
  #         "query": "3lb chicken bone-in thighs 1 medium yellow onion 1 15oz can crushed tomatoes 2 medium carrot 1 tablespoon cayenne pepper .25 teaspoon sea salt",
  #         "generalSearchInput": "3lb chicken bone-in thighs 1 medium yellow onion 1 15oz can crushed tomatoes 2 medium carrot 1 tablespoon cayenne pepper .25 teaspoon sea salt",
  #         "pageNumber": 1,
  #         "numberOfResultsPerPage": 50,
  #         "pageSize": 50,
  #         "requireAllWords": false,
  #         "foodTypes": [
  #             "Foundation"
  #         ]
  #     },
  #     "foods": [
  #         {
  #             "fdcId": 2685581,
  #             "description": "Tomatoes, crushed, canned",
  #             "commonNames": "",
  #             "additionalDescriptions": "",
  #             "dataType": "Foundation",
  #             "ndbNumber": 11693,
  #             "publishedDate": "2024-04-18",
  #             "foodCategory": "Vegetables and Vegetable Products",
  #             "mostRecentAcquisitionDate": "2023-12-01",
  #             "allHighlightFields": "",
  #             "score": 1005.94507,
  #             "microbes": [],
  #             "foodNutrients": [
  #                 {
  #                     "nutrientId": 1089,
  #                     "nutrientName": "Iron, Fe",
  #                     "nutrientNumber": "303",
  #                     "unitName": "MG",
  #                     "derivationCode": "A",
  #                     "derivationDescription": "Analytical",
  #                     "derivationId": 1,
  #                     "value": 2.27,
  #                     "foodNutrientSourceId": 1,
  #                     "foodNutrientSourceCode": "1",
  #                     "foodNutrientSourceDescription": "Analytical or derived from analytical",
  #                     "rank": 5400,
  #                     "indentLevel": 1,
  #                     "foodNutrientId": 33831343,
  #                     "dataPoints": 8,
  #                     "min": 0.683,
  #                     "max": 9.83,
  #                     "median": 0.886
  #                 },
  #               }
  #             ]
  #         }
  #     ]
  # }

  require "httparty"
  BASE_URL = "https://api.nal.usda.gov/fdc/v1"

  class << self
    def get_foods_search(query)
      response = HTTParty.get(
        "#{BASE_URL}/foods/search",
        query: {
          api_key: Rails.application.credentials.usda_api_key,
          query: query,
          dataType: "Foundation,SR Legacy",
          pageSize: 1
        },
        format: :json,
        parser: ->(body, format) { JSON.parse(body, symbolize_names: true) }
      )
      puts response.parsed_response
      handle_response(response)
    end

    private

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
