# frozen_string_literal: true

module Mako
  class MakoLogger < Logger
    def initialize(logdev, shift_age = 0, shift_size = 1_048_576)
      super(logdev, shift_age, shift_size)
      self.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end
    end
  end
end
