# frozen_string_literal: true

module Mako
  class FeedRequester
    attr_reader :feed_url
    attr_accessor :ok, :body

    def initialize(args)
      @ok = true
      @body = ''
      @feed_url = args.fetch(:feed_url)
    end

    # Performs HTTP request on the given feed_url. Sets the Mako::FeedRequester
    # body attribute equal to the request body if successful and returns self.
    # If the request fails, @ok is set to false.
    #
    # @return [Mako::FeedRequester]
    def fetch
      begin
        request = Faraday.get(feed_url)
      rescue Faraday::Error
        Mako.errors.add_error "Could not complete request to #{feed_url}."
        self.ok = false
        return self
      end
      self.body = request.body
      self
    end

    # Predicate method returning the value of @ok
    #
    # @return [Boolean]
    def ok?
      ok
    end
  end
end
