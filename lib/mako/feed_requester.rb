# frozen_string_literal: true

module Mako
  class FeedRequester
    attr_reader :feed_url
    attr_accessor :ok, :body, :headers

    def initialize(args)
      @ok = true
      @body = ''
      @headers = {}
      @feed_url = args.fetch(:feed_url)
    end

    # Performs HTTP request on the given feed_url. Sets the Mako::FeedRequester
    # body attribute equal to the request body if successful and returns self.
    # If the request fails, @ok is set to false.
    #
    # @return [Mako::FeedRequester]
    def fetch
      begin
        request = HTTParty.get(feed_url)
      rescue StandardError => e
        Mako.errors.add_error "Could not complete request to #{feed_url}: #{e.class}."
        self.ok = false
        return self
      end
      unless request.code == 200
        Mako.errors.add_error "Request to #{feed_url} returned #{request.code}."
        self.ok = false
        return self
      end
      self.headers = request.headers
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
