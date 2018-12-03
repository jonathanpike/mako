# frozen_string_literal: true

require_relative '../test_helper'

class ArticleTest < Minitest::Test
  def test_article_body_is_sanitized_without_images
    Mako.config.stub :sanitize_images, true do
      @article = Mako::Article.new(title: 'Test Article',
                                   published: Time.now,
                                   summary: "<h1>Hello</h1> \n <p>This is an article</p> <img src='example'>",
                                   url: 'http://example.com')
      assert_equal "<p class=\"bold\">Hello</p> \n <p>This is an article</p> <a src=\"example\" href=\"http://example.com/example\">📷 Image</a>", @article.summary
    end
  end

  def text_article_body_ignores_malformed_image_uris
    Mako.config.stub :sanitize_images, true do
      @article = Mako::Article.new(title: 'Test Article',
                                   published: Time.now,
                                   summary: "<h1>Hello</h1> \n <p>This is an article</p> <img src='https://example.com/blog/images/malformed image uri.jpg'>",
                                   url: 'http://example.com')
      assert_equal "<p class=\"bold\">Hello</p> \n <p>This is an article</p> ", @article.summary
    end
  end

  def test_article_body_is_sanitized_with_images
    Mako.config.stub :sanitize_images, false do
      @article = Mako::Article.new(title: 'Test Article',
                                   published: Time.now,
                                   summary: "<h1>Hello</h1> \n <p>This is an article</p> <img src='example'>",
                                   url: 'http://example.com')
      assert_equal "<p class=\"bold\">Hello</p> \n <p>This is an article</p> <img src=\"example\">", @article.summary
    end
  end
end
