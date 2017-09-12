# frozen_string_literal: true

module Mako
  class Article
    attr_reader :title, :published, :summary, :uri

    def initialize(args)
      @title = args.fetch(:title, '')
      @published = args.fetch(:published)
      @uri = URI.parse(args.fetch(:url))
      @summary = sanitize(args.fetch(:summary))
    end

    # Converts published Time object to formatted string
    #
    # @return [String]
    def formatted_published
      @published.strftime('%A, %d %B %Y at %I:%M %P')
    end

    # Converts URI object into string
    #
    # @return [String]
    def url
      uri.to_s
    end

    private

    # Transforms img tags into a tags (if configured) and transforms h1 tags
    # into p tags with the class bold
    #
    # @param [String] html an html document string
    # @return [String] a sanitized html document string
    def sanitize(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      if Mako.config.sanitize_images
        doc.css('img').each do |n|
          n.name = 'a'
          n.content = n['alt'] ? "📷 #{n['alt']}" : '📷 Image'
          n['href'] = URI.parse(n['src']).absolutize!(uri)
        end
      end
      doc.css('h1,h2,h3,h4,h5,h6').each { |n| n.name = 'p'; n.set_attribute('class', 'bold') }
      doc.to_s
    end
  end
end
