# frozen_string_literal: true

class CronometerParser
  attr_reader :raw_iframe_code
  def initialize(raw_iframe_code)
    @raw_iframe_code = raw_iframe_code
  end

  def valid_iframe_data?
    food_number.present? && measure_number.present?
  end

  def sanitized_iframe_src
    return unless valid_iframe_data?

    "https://cronometer.com/facts.html?food=#{food_number}&measure=#{measure_number}&labelType=AMERICAN"
  end

  private

  def food_number
    match = raw_iframe_code.match(/.*food=(\d*)&/)
    match.present? && match[1].present? ? match[1] : nil
  end

  def measure_number
    match = raw_iframe_code.match(/.*measure=(\d*)&/)
    match.present? && match[1].present? ? match[1] : nil
  end
end
