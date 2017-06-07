# frozen_string_literal: true

module Mako
  class Errors
    attr_accessor :messages

    def initialize
      @messages = []
    end

    # Add an error message to the messages array
    #
    # @param [String]
    def add_error(msg)
      messages << msg
    end

    # Predicate method to see if there are any error messages
    #
    # @return [Boolean]
    def any?
      messages.count.positive?
    end
  end
end
