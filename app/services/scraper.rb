# frozen_string_literal: true

# https://www.zenrows.com/blog/web-scraping-ruby#extract-data
# https://www.scrapingbee.com/blog/web-scraping-ruby/

class Scraper
  MAX_REDIRECTS = 3
  MAX_BODY_BYTES = 5 * 1024 * 1024
  OPEN_TIMEOUT = 5
  READ_TIMEOUT = 10
  USER_AGENT = "FoodPlanner recipe importer"

  attr_reader :site_content, :print_url

  def initialize(endpoint)
    @endpoint = endpoint
    @site_content = nil
    @print_url = nil
    scrape
  end

  def scrape
    html = fetch_safely(@endpoint)
    return if html.blank?

    doc = Nokogiri::HTML(html)
    @print_url = extract_print_url(doc)
    @site_content = extract_site_content(doc)
  rescue => e
    puts "Error scraping site: #{e.message}"
    Rails.logger.error("Scraper: Error scraping site: #{e.message}")
  end

  private

  # Many sites have unexpected redirects, so we need to guard ourselves against
  # malicious ones. This checks for redirect validity before continuing.
  def fetch_safely(url, redirects_remaining = MAX_REDIRECTS)
    UrlSafetyValidator.validate!(url)

    response = HTTParty.get(
      url,
      follow_redirects: false,
      open_timeout: OPEN_TIMEOUT,
      read_timeout: READ_TIMEOUT,
      headers: {"User-Agent" => USER_AGENT}
    )

    location = response.headers["location"]
    if response.code.between?(300, 399) && location.present?
      raise "Too many redirects" if redirects_remaining <= 0

      return fetch_safely(URI.join(url, location).to_s, redirects_remaining - 1)
    end

    body = response.body.to_s
    raise "Response too large" if body.bytesize > MAX_BODY_BYTES

    body
  end

  def extract_print_url(doc)
    print_link = doc.css("a").find { |link| link.text.downcase.include?("print") }
    print_link ? print_link["href"] : nil
  end

  def extract_site_content(doc)
    items = doc.css("li").filter_map { |li| li.text.squish unless li.text.blank? }
    items.join("\n")
  end
end
