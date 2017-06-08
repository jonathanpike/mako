# frozen_string_literal: true

require_relative 'test_helper'

class FeedTest < Minitest::Test
  def setup
    @feed = Mako::Feed.new(url: 'https://jonathanpike.net',
                           title: 'Jonathan Pike, software developer')
    @article1 = Mako::Article.new(title: 'Post 1',
                                  published: Time.now - 1.day,
                                  summary: 'Summary for Post 1',
                                  url: 'https://jonathanpike.net/post-1')
    @article2 = Mako::Article.new(title: 'Post 2',
                                  published: Time.now - 2.days,
                                  summary: 'Summary for Post 2',
                                  url: 'https://jonathanpike.net/post-2')
    @article3 = Mako::Article.new(title: 'Post 3',
                                  published: Time.now - 3.days,
                                  summary: 'Summary for Post 3',
                                  url: 'https://jonathanpike.net/post-3')
    @articles = [@article3, @article1, @article2]
    @feed.articles = @articles
  end

  def test_articles_desc_returns_articles_in_decending_order
    expected = ['Post 1', 'Post 2', 'Post 3']
    actual = @feed.articles_desc.map(&:title)
    assert_equal expected, actual
  end

  def test_articles_asc_returns_articles_in_ascending_order
    expected = ['Post 3', 'Post 2', 'Post 1']
    actual = @feed.articles_asc.map(&:title)
    assert_equal expected, actual
  end
end
