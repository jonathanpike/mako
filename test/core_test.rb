require_relative 'test_helper'

class CoreTest < Minitest::Test
  def setup
    @subscription_list = ['https://jonathanpike.net/feed.xml']
    @subscription_list_no_items = []
    Mako.logger.level = Logger::FATAL
  end

  def test_build_works_as_expected
    requester = Minitest::Mock.new
    constructor = Minitest::Mock.new
    renderer = Minitest::Mock.new
    writer = Minitest::Mock.new

    requester.expect :new, requester, [{ feed_url: 'https://jonathanpike.net/feed.xml' }]
    requester.expect :fetch, requester
    requester.expect :ok?, true
    requester.expect :body, TestHelper.xml_feed
    requester.expect :feed_url, 'https://jonathanpike.net/feed.xml'
    constructor.expect :new, constructor, [Hash]
    constructor.expect :parse_and_create, true
    renderer.expect :new, renderer, [Hash]
    renderer.expect :file_path, 'index.html'
    writer.expect :new, writer, [{ renderer: renderer, destination: File.expand_path('index.html', Mako.config.destination) }]
    writer.expect :write, nil

    core = Mako::Core.new(requester: requester,
                          constructor: constructor,
                          renderers: [renderer],
                          writer: writer,
                          subscription_list: @subscription_list)

    core.build

    requester.verify
    constructor.verify
    renderer.verify
    writer.verify
  end

  def test_build_exits_if_subscriptions_list_is_empty
    requester = Minitest::Mock.new
    constructor = Minitest::Mock.new
    renderer = Minitest::Mock.new
    writer = Minitest::Mock.new

    core = Mako::Core.new(requester: requester,
                          constructor: constructor,
                          renderers: [renderer],
                          writer: writer,
                          subscription_list: @subscription_list_no_items)

    _out, err = capture_io do
      core.build
    end

    assert_match err, 'No feeds were found in your subscriptions file. Please add feeds and try again'
  end
end
