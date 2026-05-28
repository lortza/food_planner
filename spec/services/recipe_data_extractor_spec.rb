# frozen_string_literal: true

require "rails_helper"

RSpec.describe RecipeDataExtractor, type: :service do
  let(:source_url) { "https://www.samplesite.com/recipe" }
  let(:recipe_json) {
    '{"title":"Test Recipe","instructions":"Step 1: Do something.\\n\\nStep 2: Do something else.","ingredients_text":"1 cup flour\\n2 eggs","ingredients":[{"name":"flour","quantity":1,"measurement_unit":"cup","preparation_style":""}],"servings":"4","prep_time":"15","cook_time":"30","total_time":"45","image_url":"https://www.example.com/image.jpg"}'
  }
  let(:successful_anthropic_response) {
    {"content" => [{"type" => "text", "text" => recipe_json}]}
  }
  let(:expected_parsed_data) {
    {
      "title" => "Test Recipe",
      "instructions" => "Step 1: Do something.\n\nStep 2: Do something else.",
      "ingredients_text" => "1 cup flour\n2 eggs",
      "ingredients" => [{"name" => "flour", "quantity" => 1, "measurement_unit" => "cup", "preparation_style" => ""}],
      "servings" => "4",
      "prep_time" => "15",
      "cook_time" => "30",
      "total_time" => "45",
      "image_url" => "https://www.example.com/image.jpg"
    }
  }

  describe ".extract" do
    context "when a body is provided" do
      let(:provided_body) { "1 cup flour\n2 eggs\n\nMix and bake." }

      before do
        allow(AnthropicApiClient).to receive(:create_message).and_return(successful_anthropic_response)
      end

      it "parses the provided body with the LLM and returns parsed data" do
        expect(RecipeDataExtractor.extract(source_url: source_url, provided_body: provided_body)).to eq(expected_parsed_data)
      end

      it "does not use the Scraper" do
        expect(Scraper).not_to receive(:new)
        RecipeDataExtractor.extract(source_url: source_url, provided_body: provided_body)
      end
    end

    context "when no body is provided and the page has a print url" do
      let(:print_url) { "https://www.samplesite.com/recipe/print" }
      let(:page_scraper) { instance_double(Scraper, print_url: print_url, site_content: "page content") }
      let(:print_scraper) { instance_double(Scraper, print_url: nil, site_content: "print page content") }

      before do
        allow(Scraper).to receive(:new).with(source_url).and_return(page_scraper)
        allow(Scraper).to receive(:new).with(print_url).and_return(print_scraper)
        allow(AnthropicApiClient).to receive(:create_message).and_return(successful_anthropic_response)
      end

      it "scrapes the print page and parses its content" do
        expect(Scraper).to receive(:new).with(print_url).and_return(print_scraper)
        expect(RecipeDataExtractor.extract(source_url: source_url)).to eq(expected_parsed_data)
      end
    end

    context "when no body is provided and the page has no print url" do
      let(:page_scraper) { instance_double(Scraper, print_url: nil, site_content: "page content") }

      before do
        allow(Scraper).to receive(:new).with(source_url).and_return(page_scraper)
        allow(AnthropicApiClient).to receive(:create_message).and_return(successful_anthropic_response)
      end

      it "parses the scraped site content" do
        expect(RecipeDataExtractor.extract(source_url: source_url)).to eq(expected_parsed_data)
      end
    end

    context "when the scraper returns no content" do
      let(:page_scraper) { instance_double(Scraper, print_url: nil, site_content: "") }

      before do
        allow(Scraper).to receive(:new).with(source_url).and_return(page_scraper)
      end

      it "returns an empty hash without calling the LLM" do
        expect(AnthropicApiClient).not_to receive(:create_message)
        expect(RecipeDataExtractor.extract(source_url: source_url)).to eq({})
      end
    end

    context "when the AnthropicApiClient raises an error" do
      before do
        allow(AnthropicApiClient).to receive(:create_message).and_raise(StandardError.new("API Error"))
      end

      it "rescues the error and returns an empty hash" do
        expect { RecipeDataExtractor.extract(source_url: source_url, provided_body: "x") }.to output(/An error occurred: API Error/).to_stdout
        expect(RecipeDataExtractor.extract(source_url: source_url, provided_body: "x")).to eq({})
      end
    end

    context "when the LLM returns invalid JSON" do
      let(:invalid_json_response) { {"content" => [{"type" => "text", "text" => "This is not valid JSON"}]} }

      before do
        allow(AnthropicApiClient).to receive(:create_message).and_return(invalid_json_response)
      end

      it "rescues the error and returns an empty hash" do
        expect { RecipeDataExtractor.extract(source_url: source_url, provided_body: "x") }.to output(/JSON parsing error/).to_stdout
        expect(RecipeDataExtractor.extract(source_url: source_url, provided_body: "x")).to eq({})
      end
    end
  end

  describe ".build_recipe" do
    let(:user) { create(:user) }
    let(:recipe) { build(:recipe, user: user, source_url: source_url, title: nil, image_url: nil) }

    it "derives the source_name from the source_url host" do
      result = RecipeDataExtractor.build_recipe(recipe: recipe, extracted_data: expected_parsed_data)
      expect(result.source_name).to eq("samplesite.com")
    end

    it "populates recipe fields and builds ingredients from extracted data" do
      result = RecipeDataExtractor.build_recipe(recipe: recipe, extracted_data: expected_parsed_data)

      expect(result.title).to eq("Test Recipe")
      expect(result.servings).to eq(4)
      expect(result.prep_time).to eq(15)
      expect(result.cook_time).to eq(30)
      expect(result.image_url).to eq("https://www.example.com/image.jpg")
      expect(result.ingredients.map(&:name)).to include("flour")
    end

    context "when the source_url is blank" do
      let(:recipe) { build(:recipe, user: user, source_url: nil) }

      it "leaves source_name nil instead of raising" do
        expect {
          @result = RecipeDataExtractor.build_recipe(recipe: recipe, extracted_data: expected_parsed_data)
        }.not_to raise_error
        expect(@result.source_name).to be_nil
      end
    end

    context "when the source_url is not a parseable URI" do
      let(:recipe) { build(:recipe, user: user, source_url: "not a url with spaces") }

      it "leaves source_name nil instead of raising" do
        expect {
          @result = RecipeDataExtractor.build_recipe(recipe: recipe, extracted_data: expected_parsed_data)
        }.not_to raise_error
        expect(@result.source_name).to be_nil
      end
    end
  end
end
