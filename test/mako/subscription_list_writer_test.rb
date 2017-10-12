# frozen_string_literal: true

require_relative '../test_helper'

class SubscriptionListWriterTest < Minitest::Test
  def setup
    @xml_subscription = File.expand_path('../helper_files/subscriptions.xml', __dir__)
    @json_subscription = File.expand_path('../helper_files/subscriptions.json', __dir__)
    @txt_subscription = File.expand_path('../helper_files/subscriptions.txt', __dir__)
    @original = %w[https://jonathanpike.net/feed.xml https://daringfireball.net/feeds/main https://marco.org/rss
                   http://blog.joshualongbrake.com/rss http://furbo.org/feed/ http://leancrew.com/all-this/feed/
                   http://rss.desiringgod.org http://gilandamy.blogspot.com/feeds/posts/default?alt=rss
                   https://www.challies.com/feed http://karbonbased.io/index.xml https://panic.com/blog/feed/
                   https://www.schneems.com/feed.xml http://rideearth.net/feed/ http://inessential.com/xml/rss.xml
                   http://scripting.com/feed.xml https://www.speedshop.co/feed.xml https://tenderlovemaking.com/atom.xml]
    @expected = %w[https://jonathanpike.net/feed.xml https://daringfireball.net/feeds/main https://marco.org/rss
                   http://blog.joshualongbrake.com/rss http://furbo.org/feed/ http://leancrew.com/all-this/feed/
                   http://rss.desiringgod.org http://gilandamy.blogspot.com/feeds/posts/default?alt=rss
                   https://www.challies.com/feed http://karbonbased.io/index.xml https://panic.com/blog/feed/
                   https://www.schneems.com/feed.xml http://rideearth.net/feed/ http://inessential.com/xml/rss.xml
                   http://scripting.com/feed.xml https://www.speedshop.co/feed.xml https://tenderlovemaking.com/atom.xml
                   https://m.signalvnoise.com/feed http://blog.testdouble.com/index.xml https://512pixels.net/feed/]
    @additional_feeds = %w[https://m.signalvnoise.com/feed http://blog.testdouble.com/index.xml https://512pixels.net/feed/]
  end

  def test_json_file_append_and_render
    actual = Mako::SubscriptionListWriter.new(feeds: @additional_feeds, destination: @json_subscription).send(:append_and_render)
    assert_equal @expected.to_json, actual
  end

  def test_txt_file_append_and_render
    actual = Mako::SubscriptionListWriter.new(feeds: @additional_feeds, destination: @txt_subscription).send(:append_and_render)
    assert_equal @expected.join("\n"), actual
  end

  def test_xml_file_append_and_render
    actual = Mako::SubscriptionListWriter.new(feeds: @additional_feeds, destination: @xml_subscription).send(:append_and_render)
    expected = Mako::SubscriptionListParser.new(list: File.expand_path('../helper_files/subscriptions_updated.xml', __dir__)).load_list
    assert_equal expected, actual
  end
end
