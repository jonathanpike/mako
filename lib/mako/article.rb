# frozen_string_literal: true

module Mako
  class Article
    attr_reader :title, :published, :summary, :url

    def initialize(args)
      @title = args.fetch(:title, '')
      @published = args.fetch(:published)
      @summary = sanitize(args.fetch(:summary))
      @url = args.fetch(:url)
    end

    # Converts published Time object to formatted string
    #
    # @return [String]
    def formatted_published
      @published.strftime('%A, %d %B %Y')
    end

    private

    # @private
    # Removes img tags (if configured) and transforms h1 tags into
    # p tags with the class bold
    #
    # @param [String] html an html document string
    # @return [String] a sanitized html document string
    def sanitize(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('img').each(&:remove) if Mako.config.sanitize_images
      doc.css('h1,h2,h3,h4,h5,h6').each { |n| n.name = 'p'; n.set_attribute('class', 'bold') }
      doc.to_s
    end
  end
end
