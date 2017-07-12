# frozen_string_literal: true

require_relative '../test_helper'

class FeedRequesterTest < Minitest::Test
  def setup
    @ok_feed_requester = Mako::FeedRequester.new(feed_url: 'https://jonathanpike.net/feed.xml')
    @not_ok_feed_requester = Mako::FeedRequester.new(feed_url: 'http://this-is-not-a-domain.com/feed.xml')
    @feed_requester404 = Mako::FeedRequester.new(feed_url: 'https://jonathanpike.net/noop')
  end

  def test_fetch_returns_httparty_object
    VCR.use_cassette('working_feed') do
      feed = @ok_feed_requester.fetch
      assert_instance_of Mako::FeedRequester, feed
      assert feed.ok?
      assert !feed.body.empty?
    end
  end

  def test_fetch_failure_error
    VCR.use_cassette('not_working_feed') do
      @not_ok_feed_requester.fetch
      refute @not_ok_feed_requester.ok?
      assert_includes Mako.errors.messages, "Could not complete request to #{@not_ok_feed_requester.feed_url}."
    end
  end

  def test_fetch_failure_404
    VCR.use_cassette('feed_404') do
      @feed_requester404.fetch
      refute @feed_requester404.ok?
      assert_includes Mako.errors.messages, "Request to #{@feed_requester404.feed_url} returned 404."
    end
  end
end
