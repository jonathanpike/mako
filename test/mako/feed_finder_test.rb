# frozen_string_literal: true

require_relative '../test_helper'

class FeedFinderTest < Minitest::Test
  def setup
    @urls = %w[https://daringfireball.net https://jonathanpike.net https://marco.org
               http://blog.joshualongbrake.com http://furbo.org http://leancrew.com/all-this
               http://panic.com/blog https://www.schneems.com http://inessential.com
               m.signalvnoise.com]
    @expected = %w[https://daringfireball.net/feeds/main https://www.jonathanpike.net/feed.xml
                   http://marco.org/rss http://blog.joshualongbrake.com/rss http://furbo.org/feed/
                   http://leancrew.com/all-this/feed/ https://panic.com/blog/feed/
                   https://www.schneems.com/feed.xml http://inessential.com/xml/rss.xml
                   https://m.signalvnoise.com/feed]
  end

  def test_find_returns_expected_results
    VCR.use_cassette('fetch_feeds_for_finder') do
      found_urls = Mako::FeedFinder.new(uris: @urls).find
      assert_equal @expected, found_urls
    end
  end

  def test_find_with_existing_feed_url
    existing_feed_urls = %w[http://inessential.com/xml/rss.xml https://panic.com/blog/feed/]
    VCR.use_cassette('find_existing_feed_urls') do
      found_urls = Mako::FeedFinder.new(uris: existing_feed_urls).find
      assert_equal existing_feed_urls, found_urls
    end
  end

  def test_with_existing_feed_url_with_wrong_mime_type
    existing_feed_url = ['https://marco.org/rss']
    VCR.use_cassette('find_existing_feed_url_with_wrong_mime') do
      found_url = Mako::FeedFinder.new(uris: existing_feed_url).find
      assert_equal [], found_url
    end
  end
end
