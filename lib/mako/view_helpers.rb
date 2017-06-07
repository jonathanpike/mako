# frozen_string_literal: true

module ViewHelpers
  # Returns today's date in Day, Date Month Year format
  #
  # @return [String]
  def today
    Time.now.strftime('%A, %d %B %Y')
  end

  # Returns the current time in month day year hour:minute:second format
  #
  # @return [String]
  def last_updated
    Time.now.strftime('%m %b %Y %H:%M:%S')
  end
end
