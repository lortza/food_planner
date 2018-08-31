# frozen_string_literal: true

module TimeHelper
  class << self
    MINUTES_IN_AN_HOUR = 60

    def display_time(minutes)
      return display_minutes_greater_than_an_hour(minutes) if minutes > MINUTES_IN_AN_HOUR

      display_minutes_less_than_an_hour(minutes)
    end

    private

    def display_minutes_greater_than_an_hour(minutes)
      "#{minutes / MINUTES_IN_AN_HOUR}h #{minutes % MINUTES_IN_AN_HOUR}m"
    end

    def display_minutes_less_than_an_hour(minutes)
      "#{minutes}m"
    end
  end
end
