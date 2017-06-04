require_relative '../version'

module Mako
  class Version
    def self.perform(_args)
      puts "mako #{VERSION}"
    end
  end
end
