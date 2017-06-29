# frozen_string_literal: true

module Mako
  class Find
    XPATHS = ["//link[@rel='alternate'][@type='application/rss+xml']/@href",
              "//link[@rel='alternate'][@type='application/atom+xml']/@href",
              "//link[@rel='alternate'][@type='application/json']/@href"].freeze

    def self.perform(args)
      if args.empty?
        Mako.errors.add_error 'No feeds to find'
        return
      end
      find_and_parse_urls(args)
    end

    def self.find_and_parse_urls(urls)
      urls.map do |url|
        uri = URI.parse(url)
        request = Mako::FeedRequester.new(feed_url: url)
        next unless request.ok?
        html = Nokogiri::HTML(request.body)
        uri_string = html.xpath(XPATHS.detect { |path| !html.xpath(path).empty? }).first.value
        feed_uri = URI.parse(uri_string)
        if uri.host == feed_uri.host
          uri.to_s
        else
          uri.merge(feed_uri)
        end
      end
    end
  end

  def self.write_to_subscriptions(feed_urls)
    path = File.expand_path(Dir.glob('subscriptions.*').first, Dir.pwd)
  end
end
