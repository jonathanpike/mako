require_relative 'test_helper'

class FeedConstructorTest < Minitest::Test
  def setup
    @xml_feed = TestHelper.xml_feed
    @json_feed = TestHelper.json_feed
    @not_xml = TestHelper.not_xml
    @feed_constructor = Mako::FeedConstructor.new(feed_data: @xml_feed, feed_url: 'https://jonathanpike.net/feed.xml')
  end

  def test_parse_and_create_with_articles_when_in_date_range
    Time.stub :now, Time.new(2017, 3, 7, 0, 0, 0) do
      feed = @feed_constructor.parse_and_create
      assert_equal 1, feed.articles.count
      assert_equal 'Jonathan Pike, software developer', feed.title
      assert_equal 'https://www.jonathanpike.net/', feed.url
    end
  end

  def test_parse_and_create_without_articles_when_out_of_date_range
    feed = @feed_constructor.parse_and_create
    assert_equal 0, feed.articles.count
    assert_equal 'Jonathan Pike, software developer', feed.title
    assert_equal 'https://www.jonathanpike.net/', feed.url
  end

  def test_parse_and_create_with_incompatible_feed_format
    @feed_constructor = Mako::FeedConstructor.new(feed_data: @json_feed, feed_url: 'https://jonathanpike.net/feed.json')
    @feed_constructor.parse_and_create
    assert_includes Mako.errors.messages, "Unable to parse #{@feed_constructor.feed_url}."
  end

  def test_parse_and_create_with_not_xml_document
    @feed_constructor = Mako::FeedConstructor.new(feed_data: @not_xml, feed_url: 'https://jonathanpike.net')
    @feed_constructor.parse_and_create
    assert_includes Mako.errors.messages, "Unable to parse #{@feed_constructor.feed_url}."
  end
end
