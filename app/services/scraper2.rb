# frozen_string_literal: true

# Fetches a recipe page and exposes the parsed Nokogiri doc plus a few
# small conveniences (print-friendly URL detection, raw HTML).
#
# Kept intentionally thin — all recipe-shaped parsing lives in
# RecipeDataExtractor2. This object only knows how to GET the page.
class Scraper2
  require "open-uri"

  USER_AGENT = "Mozilla/5.0 (compatible; FoodPlannerBot/1.0)"
  OPEN_TIMEOUT = 5
  READ_TIMEOUT = 15

  attr_reader :doc, :html, :error

  def initialize(endpoint)
    @endpoint = endpoint
    fetch
  end

  def success?
    @error.nil? && @doc
  end

  # Returns a URL to a print-friendly version of the recipe, if one is linked
  # from the page. Many recipe sites strip ads/comments/story on /print pages,
  # which makes downstream parsing dramatically more reliable.
  def print_url
    return nil unless success?

    link = @doc.css("a").find { |a| a.text.to_s.downcase.strip == "print" } ||
      @doc.css("a[href*='print']").first
    return nil unless link

    href = link["href"]
    return nil if href.blank?

    URI.join(@endpoint, href).to_s
  rescue URI::InvalidURIError
    nil
  end

  # Refetches against the print URL and returns a new Scraper2 pointed at it.
  # Returns self if no print URL is available.
  def follow_print_url
    url = print_url
    return self if url.nil? || url == @endpoint

    self.class.new(url)
  end

  private

  def fetch
    @html = URI.parse(@endpoint).open(
      "User-Agent" => USER_AGENT,
      :open_timeout => OPEN_TIMEOUT,
      :read_timeout => READ_TIMEOUT
    ).read
    @doc = Nokogiri::HTML(@html)
  rescue => e
    @error = e.message
    @doc = nil
    @html = nil
  end
end
