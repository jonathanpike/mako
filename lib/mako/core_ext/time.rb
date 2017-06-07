# frozen_string_literal: true

require 'time'

class Time
  def beginning_of_day
    Time.new(year, month, day,
             0, 0, 0, utc_offset)
  end
end
