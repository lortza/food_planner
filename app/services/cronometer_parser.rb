# frozen_string_literal: true

class CronometerParser
  attr_reader :raw_iframe_code
  def initialize(raw_iframe_code)
    @raw_iframe_code = raw_iframe_code
  end

  def sanitized_iframe_src
    "https://cronometer.com/facts.html?food=#{food_number}&measure=#{measure_number}&labelType=AMERICAN"
  end

  def food_number
    raw_iframe_code.split('food=').last.split('&').first
  end

  def measure_number
    raw_iframe_code.split('measure=').last.split('&').first
  end
end
