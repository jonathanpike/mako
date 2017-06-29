# frozen_string_literal: true

require_relative 'test_helper'

class FindTest < Minitest::Test
  def setup 
    @urls = ["https://daringfireball.net", "https://jonathanpike.net", "https://marco.org",
            "http://blog.joshualongbrake.com", "http://furbo.org", "http://leancrew.com/all-this",
            "http://panic.com/blog", "https://www.schneems.com", "http://inessential.com"]
    @expected = ["https://daringfireball.net/feeds/main", "https://jonathanpike.net/feed.xml",
                "http://marco.org/rss", "http://blog.joshualongbrake.com/rss", "http://furbo.org/feed/",
                "http://leancrew.com/all-this/feed/", "http://panic.com/blog/feed/",
                "http://www.schneems.com/feed.xml", "http://inessential.com/xml/rss.xml"]
  end

  def test_find_and_parse_returns_array
    found_urls = Mako::Find.find_and_parse_urls(@urls)
    assert_equal @expected, found_urls
  end
end
