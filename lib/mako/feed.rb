# frozen_string_literal: true

module Mako
  class Feed
    attr_accessor :feed_url, :url, :title, :articles

    def initialize(args)
      @url = args.fetch(:url)
      @title = args.fetch(:title)
      @articles = []
    end

    # Returns the articles array sorted by date published ascending
    # (oldest first).
    #
    # @return [Array]
    def articles_asc
      articles.sort_by(&:published)
    end

    # Returns the articles array sorted by date published descending
    # (newest first).
    #
    # @return [Array]
    def articles_desc
      articles_asc.reverse
    end
  end
end
