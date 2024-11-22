# frozen_string_literal: true

class CronometerParser
  attr_reader :raw_iframe_code
  def initialize(raw_iframe_code)
    @raw_iframe_code = raw_iframe_code
  end

  def valid_iframe_data?
    return false unless raw_iframe_code.present?

    food_number.present? && measure_number.present?
  end

  def sanitized_iframe_src
    return nil unless valid_iframe_data?

    "https://cronometer.com/facts.html?food=#{food_number}&measure=#{measure_number}&labelType=AMERICAN"
  end

  private

  def food_number
    match_data = raw_iframe_code.match(/.*food=(\d*)&/)
    (match_data.present? && match_data[1].present?) ? match_data[1] : nil
  end

  def measure_number
    match_data = raw_iframe_code.match(/.*measure=(\d*)&/)
    (match_data.present? && match_data[1].present?) ? match_data[1] : nil
  end
end
