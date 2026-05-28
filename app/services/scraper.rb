# frozen_string_literal: true

# https://www.zenrows.com/blog/web-scraping-ruby#extract-data
# https://www.scrapingbee.com/blog/web-scraping-ruby/

class Scraper
  require "open-uri"

  attr_reader :site_content, :print_url

  def initialize(endpoint)
    @endpoint = endpoint
    @site_content = nil
    @print_url = nil
    scrape
  end

  def scrape
    html = URI.parse(@endpoint).open
    doc = Nokogiri::HTML(html)
    @print_url = extract_print_url(doc)
    @site_content = extract_site_content(doc)
  rescue => e
    puts "Error scraping site: #{e.message}"
    Rails.logger.error("Scraper: Error scraping site: #{e.message}")
  end

  private

  def extract_print_url(doc)
    print_link = doc.css("a").find { |link| link.text.downcase.include?("print") }
    print_link ? print_link["href"] : nil
  end

  def extract_site_content(doc)
    items = doc.css("li").filter_map { |li| li.text.squish unless li.text.blank? }
    items.join("\n")
  end
end
