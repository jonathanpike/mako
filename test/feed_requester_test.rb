require_relative 'test_helper'

class FeedRequesterTest < Minitest::Test
  def setup
    @ok_feed_requester = Mako::FeedRequester.new(feed_url: 'https://jonathanpike.net/feed.xml')
    @not_ok_feed_requester = Mako::FeedRequester.new(feed_url: 'http://this-is-not-a-domain.com/feed.xml')
  end

  def test_fetch_returns_faraday_object
    VCR.use_cassette('working_feed') do
      feed = @ok_feed_requester.fetch
      assert_instance_of Mako::FeedRequester, feed
      assert feed.ok?
      assert feed.body.length > 0
    end
  end

  def test_fetch_failure_faraday_object
    VCR.use_cassette('not_working_feed') do
      @not_ok_feed_requester.fetch
      refute @not_ok_feed_requester.ok?
    end
  end
end
