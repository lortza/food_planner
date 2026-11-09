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

  describe ".create_conversation" do
    it "posts the system prompt, full history, extra fields, beta header, and timeout" do
      AnthropicApiClient.create_conversation(
        model: "claude-opus-5-5",
        system: [{type: "text", text: "be helpful"}],
        messages: [{role: "user", content: "hi"}, {role: "assistant", content: "hello"}, {role: "user", content: "again"}],
        max_tokens: 500,
        output_config: {effort: "medium"},
        fallbacks: "default",
        betas: ["beta-one", "beta-two"],
        timeout: 90
      )

      expect(HTTParty).to have_received(:post) do |_url, options|
        body = JSON.parse(options[:body])
        expect(body).to include(
          "model" => "claude-opus-5-5",
          "max_tokens" => 500,
          "system" => [{"type" => "text", "text" => "be helpful"}],
          "output_config" => {"effort" => "medium"},
          "fallbacks" => "default"
        )
        expect(body["messages"].map { |m| m["role"] }).to eq(%w[user assistant user])
        expect(options[:headers]["anthropic-beta"]).to eq("beta-one,beta-two")
        expect(options[:timeout]).to eq(90)
      end
    end

    it "omits the beta header and timeout when not given" do
      AnthropicApiClient.create_conversation(model: "m", system: "s", messages: [{role: "user", content: "hi"}])

      expect(HTTParty).to have_received(:post) do |_url, options|
        expect(options[:headers]).not_to have_key("anthropic-beta")
        expect(options).not_to have_key(:timeout)
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
