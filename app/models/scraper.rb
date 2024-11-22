# frozen_string_literal: true

# https://www.zenrows.com/blog/web-scraping-ruby#extract-data
# https://www.scrapingbee.com/blog/web-scraping-ruby/

class Scraper
  require "open-uri"

  attr_reader :site_data

  def initialize(endpoint)
    @endpoint = endpoint
    @site_data = scrape_site
  end

  private

  def scrape_site
    html = URI.parse(@endpoint).open
    doc = Nokogiri::HTML(html)
    items = doc.css("li").filter_map { |li| li.text.squish unless li.text.blank? }
    items.join("\n")
  rescue
    "could not scrape"

    # lis = doc.css('li')
    # ingredient_heading = doc.at('h2:contains("Ingredients")') || doc.at('h3:contains("Ingredients")') || doc.at('h4:contains("Ingredients")')
    # instructions_heading = doc.at('h2:contains("Instructions")') || doc.at('h3:contains("Instructions")') || doc.at('h4:contains("Instructions")')

    # doc.xpath("//h3[text()='Ingredients']/following-sibling::ul/li").each do |node|
    #   puts node.to_html
    # end
  end
end
