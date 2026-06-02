# frozen_string_literal: true

require "rails_helper"

RSpec.describe Scraper, type: :service do
  let(:url) { "https://example.com/recipe" }

  # Minimal stand-in for an HTTParty::Response.
  def http_response(code:, body: "", location: nil)
    headers = location ? {"location" => location} : {}
    double("HTTParty::Response", code: code, headers: headers, body: body)
  end

  def stub_fetch(body:, code: 200)
    allow(HTTParty).to receive(:get).and_return(http_response(code: code, body: body))
  end

  before do
    # Validation has its own spec; here we only care that Scraper consults it.
    allow(UrlSafetyValidator).to receive(:validate!)
  end

  describe "site content extraction" do
    it "joins non-blank <li> text, squished, separated by newlines" do
      stub_fetch(body: "<ul><li>  1 cup   flour </li><li></li><li>2 eggs</li></ul>")

      expect(Scraper.new(url).site_content).to eq("1 cup flour\n2 eggs")
    end

    it "is an empty string when the page has no list items" do
      stub_fetch(body: "<p>no lists here</p>")

      expect(Scraper.new(url).site_content).to eq("")
    end
  end

  describe "print url extraction" do
    it "returns the href of the first anchor whose text contains 'print' (case-insensitive)" do
      stub_fetch(body: "<a href='/home'>Home</a><a href='/recipe/print'>Print Recipe</a>")

      expect(Scraper.new(url).print_url).to eq("/recipe/print")
    end

    it "is nil when no anchor mentions print" do
      stub_fetch(body: "<a href='/home'>Home</a>")

      expect(Scraper.new(url).print_url).to be_nil
    end
  end

  describe "fetching" do
    it "validates the URL before fetching it" do
      stub_fetch(body: "<li>x</li>")

      Scraper.new(url)

      expect(UrlSafetyValidator).to have_received(:validate!).with(url)
    end

    it "requests with redirects disabled, timeouts, and a User-Agent" do
      stub_fetch(body: "<li>x</li>")

      Scraper.new(url)

      expect(HTTParty).to have_received(:get).with(
        url,
        hash_including(
          follow_redirects: false,
          open_timeout: Scraper::OPEN_TIMEOUT,
          read_timeout: Scraper::READ_TIMEOUT,
          headers: {"User-Agent" => Scraper::USER_AGENT}
        )
      )
    end
  end

  describe "redirects" do
    it "follows a redirect and re-validates the new location" do
      destination = "https://example.com/real"
      allow(HTTParty).to receive(:get).with(url, anything)
        .and_return(http_response(code: 301, location: destination))
      allow(HTTParty).to receive(:get).with(destination, anything)
        .and_return(http_response(code: 200, body: "<li>real content</li>"))

      scraper = Scraper.new(url)

      expect(UrlSafetyValidator).to have_received(:validate!).with(destination)
      expect(scraper.site_content).to eq("real content")
    end

    it "resolves a relative redirect location against the current url" do
      allow(HTTParty).to receive(:get).with(url, anything)
        .and_return(http_response(code: 302, location: "/moved"))
      allow(HTTParty).to receive(:get).with("https://example.com/moved", anything)
        .and_return(http_response(code: 200, body: "<li>moved</li>"))

      expect(Scraper.new(url).site_content).to eq("moved")
    end

    it "gives up after too many redirects, leaving content nil" do
      allow(HTTParty).to receive(:get).and_return(http_response(code: 301, location: url))

      scraper = nil
      expect { scraper = Scraper.new(url) }.to output(/Error scraping site/).to_stdout
      expect(scraper.site_content).to be_nil
      expect(scraper.print_url).to be_nil
    end
  end

  describe "safety and error handling" do
    it "does not fetch and leaves content nil when the URL is unsafe" do
      allow(UrlSafetyValidator).to receive(:validate!).and_raise(UrlSafetyValidator::UnsafeUrl, "blocked")
      expect(HTTParty).not_to receive(:get)
      expect(Rails.logger).to receive(:error).with(/blocked/)

      scraper = nil
      expect { scraper = Scraper.new(url) }.to output(/Error scraping site/).to_stdout
      expect(scraper.site_content).to be_nil
      expect(scraper.print_url).to be_nil
    end

    it "rejects a response larger than the max, leaving content nil" do
      stub_fetch(body: "a" * (Scraper::MAX_BODY_BYTES + 1))

      scraper = nil
      expect { scraper = Scraper.new(url) }.to output(/Error scraping site/).to_stdout
      expect(scraper.site_content).to be_nil
    end

    it "rescues fetch errors, logs them, and leaves content nil" do
      allow(HTTParty).to receive(:get).and_raise(SocketError.new("getaddrinfo failed"))
      expect(Rails.logger).to receive(:error).with(/getaddrinfo failed/)

      scraper = nil
      expect { scraper = Scraper.new(url) }.to output(/Error scraping site: getaddrinfo failed/).to_stdout
      expect(scraper.site_content).to be_nil
    end
  end
end
