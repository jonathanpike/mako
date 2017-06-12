# frozen_string_literal: true

require 'whenever'

module Mako
  class Schedule
    def self.perform(_args)
      Whenever::CommandLine.execute(file: File.expand_path('schedule.rb', Dir.pwd),
                                    write: true)
    end
  end
end
