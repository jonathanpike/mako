# frozen_string_literal: true

require_relative '../test_helper'

class SubscriptionListParserTest < Minitest::Test
  def setup
    @xml_subscription = File.expand_path('../helper_files/subscriptions.xml', __dir__)
    @json_subscription = File.expand_path('../helper_files/subscriptions.json', __dir__)
    @txt_subscription = File.expand_path('../helper_files/subscriptions.txt', __dir__)
    @expected = %w[https://jonathanpike.net/feed.xml https://daringfireball.net/feeds/main https://marco.org/rss http://blog.joshualongbrake.com/rss http://furbo.org/feed/ http://leancrew.com/all-this/feed/ http://rss.desiringgod.org http://gilandamy.blogspot.com/feeds/posts/default?alt=rss https://www.challies.com/feed http://karbonbased.io/index.xml https://panic.com/blog/feed/ https://www.schneems.com/feed.xml http://rideearth.net/feed/ http://inessential.com/xml/rss.xml http://scripting.com/feed.xml https://www.speedshop.co/feed.xml https://tenderlovemaking.com/atom.xml]
  end

  def test_parses_xml_subscriptions_list
    actual = Mako::SubscriptionListParser.new(list: @xml_subscription).parse
    assert_equal @expected, actual
  end

  def test_parses_json_subscriptions_list
    actual = Mako::SubscriptionListParser.new(list: @json_subscription).parse
    assert_equal @expected, actual
  end

  def test_parses_txt_subscriptions_list
    actual = Mako::SubscriptionListParser.new(list: @txt_subscription).parse
    assert_equal @expected, actual
  end
end
