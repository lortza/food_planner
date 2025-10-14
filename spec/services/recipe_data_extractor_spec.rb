# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecipeDataExtractor, type: :service do
  let(:extractor) { RecipeDataExtractor.new(iframe_code) }

  describe ".extract_from_site" do
    let(:subject) { RecipeDataExtractor.extract_from_site(source_url) }
    let(:source_url) { "https://www.samplesite.com" }
    let(:successful_anthropic_response) {
      {"content" => [
        {
          "type" => "text",
          "text" => '{"title":"Test Recipe","instructions":"Step 1: Do something.\\n\\nStep 2: Do something else.","ingredients":"1 cup flour\\n2 eggs","servings":"4","prep_time":"15","cook_time":"30","total_time":"45","image_url":"https://www.example.com/image.jpg"}'
        }
      ]}
    }
    let(:blocked_anthropic_response) {
      {"content" => [
        {"type" => "text", "text" => "site_blocked"}
      ]}
    }
    let(:expected_parsed_data) {
      {
        "title" => "Test Recipe",
        "instructions" => "Step 1: Do something.\n\nStep 2: Do something else.",
        "ingredients" => "1 cup flour\n2 eggs",
        "servings" => "4",
        "prep_time" => "15",
        "cook_time" => "30",
        "total_time" => "45",
        "image_url" => "https://www.example.com/image.jpg"
      }
    }

    context "when AnthropicApiClient returns site data" do
      before do
        # Use any_args or hash_including to match any prompt
        allow(AnthropicApiClient).to receive(:create_message).and_return(successful_anthropic_response)
      end

      it "returns parsed json data" do
        expect(subject).to eq(expected_parsed_data)
      end

      it "does not use the Scraper" do
        expect(Scraper).not_to receive(:new)
        subject
      end
    end

    context "when AnthropicApiClient returns a blocked response" do
      let(:successful_scraper_response) { "1 cup flour\n2 eggs\n\nStep 1: Do something.\nStep 2: Do something else." }
      let(:scraper_instance) { instance_double(Scraper, site_data: successful_scraper_response) }

      before do
        allow(AnthropicApiClient).to receive(:create_message).and_return(blocked_anthropic_response, successful_anthropic_response)
        allow(Scraper).to receive(:new).with(source_url).and_return(scraper_instance)
      end

      it "uses the Scraper to get site data and then re-prompts AnthropicApiClient" do
        expect(Scraper).to receive(:new).with(source_url).and_return(scraper_instance)
        expect(scraper_instance).to receive(:site_data)
        expect(AnthropicApiClient).to receive(:create_message).twice
        subject
      end

      it "returns parsed json data from the second AnthropicApiClient call" do
        expect(subject).to eq(expected_parsed_data)
      end
    end

    context "when AnthropicApiClient returns an error response" do
      before do
        allow(AnthropicApiClient).to receive(:create_message).and_raise(StandardError.new("API Error"))
      end

      it "rescues the error and returns an empty hash" do
        expect { subject }.to output(/An error occurred: API Error/).to_stdout
        expect(subject).to eq({})
      end
    end

    context "when an error occurs during extraction" do
      let(:invalid_json_response) {
        {
          "content" => [
            {"type" => "text", "text" => "This is not valid JSON"}
          ]
        }
      }

      before do
        allow(AnthropicApiClient).to receive(:create_message).and_return(invalid_json_response)
      end

      it "rescues the error and returns an empty hash" do
        expect { subject }.to output(/JSON parsing error/).to_stdout
        expect(subject).to eq({})
      end
    end
  end
end
