# frozen_string_literal: true

module NumbersHelper
  class << self
    def prettify_float(number)
      self.whole_number?(number) ? number.round : number
    end

    def whole_number?(number)
      (number % 1).zero?
    end
  end
end
