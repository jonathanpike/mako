# frozen_string_literal: true

module Mako
  class Subscribe
    def self.perform(args)
      if args.empty?
        Mako.errors.add_error 'No feeds to find'
        return
      end
      feeds = Mako::FeedFinder.new(uris: args).find
      write_to_subscriptions(feeds)
    end

    def self.write_to_subscriptions(feed_urls)
      path = File.expand_path(Dir.glob('subscriptions.*').first, Dir.pwd)
      Mako::SubscriptionListWriter.new(feeds: feed_urls, destination: path).append_and_write
    end
  end
end
