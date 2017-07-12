# frozen_string_literal: true

module Mako
  class FeedConstructor
    attr_reader :feed_url, :feed_data

    def initialize(args)
      @feed_url = args.fetch(:feed_url)
      @feed_data = args.fetch(:feed_data)
    end

    # Parses raw XML feed and creates Feed and Article objects to
    # be rendered. Returns false if feed cannot be parsed.
    #
    # @return [Feed]
    def parse_and_create
      parsed_feed = parse_feed
      return false unless parsed_feed
      feed = create_feed(parsed_feed)
      create_articles(feed, parsed_feed)
      feed
    end

    private

    # @private
    # Takes raw XML and parses it into a Feedjira::Feed object
    #
    # @return [Feedjira::Feed]
    def parse_feed
      Feedjira::Feed.parse(feed_data)
    rescue Feedjira::NoParserAvailable
      Mako.errors.add_error "Unable to parse #{feed_url}."
      return false
    end

    # Creates new Mako::Feed object from the parsed Feedjira::Feed object
    #
    # @param [Feedjira::Feed]
    # @return [Mako::Feed]
    def create_feed(parsed_feed)
      Feed.new(url: parsed_feed.url, title: parsed_feed.title)
    end

    # Creates new Mako::Article objects from the parsed Feedjira::Feed object
    # if the source article was published within the last day. Adds the
    # Mako::Article objects to the Mako::Feed object's articles attribute.
    #
    # @param [Mako::Feed] feed
    # @param [Feedjira::Feed] parsed_feed
    def create_articles(feed, parsed_feed)
      parsed_feed.entries.each do |entry|
        next unless entry.published >= (Time.now - 1.day).beginning_of_day
        feed.articles << Article.new(title: entry.title,
                                     published: entry.published,
                                     summary: entry_summary(entry),
                                     url: entry.url)
      end
    end

    # Some feeds use summary for the full article body, other feeds use content.
    # This prefers content, but falls back to summary.
    #
    # @param [Feedjira::Feed]
    # @return [String] an HTML string of the source article body
    def entry_summary(entry)
      !entry.content || entry.content.empty? ? entry.summary : entry.content
    end
  end
end
