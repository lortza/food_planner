# frozen_string_literal: true

require "rails_helper"

RSpec.describe AnthropicApiClient do
  let(:success_response) do
    instance_double(HTTParty::Response, code: 200, parsed_response: {"content" => [{"text" => "ok"}]}, body: "")
  end

  before do
    allow(HTTParty).to receive(:post).and_return(success_response)
    allow(Rails.application.credentials).to receive(:anthropic_api_key).and_return("test-key")
  end

  describe ".create_message_with_image" do
    it "posts a vision message with the image block first, then the text block" do
      AnthropicApiClient.create_message_with_image(prompt: "read this", image_data: "BASE64DATA", media_type: "image/png")

      expect(HTTParty).to have_received(:post) do |_url, options|
        body = JSON.parse(options[:body])
        content = body["messages"][0]["content"]

        expect(content[0]["type"]).to eq("image")
        expect(content[0]["source"]).to include("type" => "base64", "media_type" => "image/png", "data" => "BASE64DATA")
        expect(content[1]).to eq("type" => "text", "text" => "read this")
        expect(body["model"]).to eq(AnthropicApiClient::SONNET_MODEL_ID)
        expect(options[:headers]["anthropic-version"]).to eq("2023-06-01")
      end
    end
  end

  describe ".create_message" do
    it "posts a text-only message" do
      AnthropicApiClient.create_message(prompt: "hello")

      expect(HTTParty).to have_received(:post) do |_url, options|
        body = JSON.parse(options[:body])
        expect(body["messages"][0]["content"]).to eq("hello")
      end
    end
  end

  describe "error handling" do
    {400 => BadRequestError, 401 => UnauthorizedError, 429 => RateLimitError, 500 => ServerError, 418 => APIError}.each do |code, error_class|
      it "raises #{error_class} on a #{code} response" do
        allow(HTTParty).to receive(:post).and_return(
          instance_double(HTTParty::Response, code: code, parsed_response: {}, body: "error body")
        )

        expect { AnthropicApiClient.create_message(prompt: "x") }.to raise_error(error_class)
      end
    end
  end
end
