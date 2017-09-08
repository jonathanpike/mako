# frozen_string_literal: true

module Mako
  class FeedFinder
    # Patterns for RSS, Atom, and JSON feeds
    XPATHS = ["//link[@rel='alternate'][@type='application/rss+xml']/@href",
              "//link[@rel='alternate'][@type='application/atom+xml']/@href",
              "//link[@rel='alternate'][@type='application/json']/@href"].freeze
    MIME_TYPES = ['text/xml',
                  'application/xml',
                  'application/rss+xml',
                  'application/atom+xml',
                  'application/json'].freeze

    attr_reader :uris

    def initialize(args)
      @uris = args.fetch(:uris)
    end

    # From an array of supplied URIs, will request each one and attempt to
    # find a feed URI on the page.  If one is found, it will be added to
    # an array and returned.
    #
    # @return [Array]
    def find
      request_uris.map do |request|
        if request[:body].nil?
          request[:uri]
        else
          html = Nokogiri::HTML(request[:body])
          potential_feed_uris = html.xpath(XPATHS.detect { |path| !html.xpath(path).empty? })
          next if potential_feed_uris.empty?
          uri_string = potential_feed_uris.first.value
          feed_uri = URI.parse(uri_string)
          feed_uri.absolutize!(request[:uri])
        end
      end.compact
    end

    private

    # @private
    # Make requests for each URI passed in and return an array of hashes
    # with either just the URI (in the case that the URI passed in was already
    # a feed URI), or the URI and the response body.
    #
    # @return [Array]
    def request_uris
      uris.map do |uri|
        parsed_uri = URI.parse(uri)
        # Try giving the URI a scheme if one isn't passed
        parsed_uri = URI.parse('http://' + uri) if parsed_uri.scheme.nil?
        request = Mako::FeedRequester.new(feed_url: parsed_uri).fetch
        next unless request.ok?
        if MIME_TYPES.include? request.headers['content-type'].split(';').first
          { uri: parsed_uri.to_s }
        else
          { uri: parsed_uri, body: request.body }
        end
      end.compact
    end
  end
end
