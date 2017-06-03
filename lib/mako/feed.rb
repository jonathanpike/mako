module Mako
  class Feed
    attr_accessor :feed_url, :url, :title, :articles

    def initialize(args)
      @url = args.fetch(:url)
      @title = args.fetch(:title)
      @articles = []
    end
  end
end
