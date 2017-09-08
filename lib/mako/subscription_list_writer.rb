# frozen_string_literal: true

module Mako
  class SubscriptionListWriter
    include FileOpenUtil

    attr_reader :feeds, :destination

    def initialize(args)
      @feeds = args.fetch(:feeds)
      @destination = args.fetch(:destination)
    end

    # Appends the new subscriptions to the subscription list and
    # writes the results out to the file.
    def append_and_write
      contents = append_and_render
      File.open(destination, 'w+', encoding: 'utf-8') do |f|
        f.write(contents)
      end
    end

    private

    # Returns the rendered string for the correct file type.
    #
    # @return [String]
    def append_and_render
      loaded_list = SubscriptionListParser.new(list: destination)
      case File.extname destination
      when '.xml' || '.opml'
        render_opml(loaded_list)
      when '.json'
        render_json(loaded_list)
      when '.txt'
        render_txt(loaded_list)
      end
    end

    # Append feeds to current subscription list and return a string separated
    # by \n characters
    #
    # @return [String]
    def render_txt(list)
      (list.parse + feeds).join("\n")
    end

    # Append feeds to current subscription list and return a JSON array
    #
    # @return [String]
    def render_json(list)
      (list.parse + feeds).to_json
    end

    # Append feeds to current subscription list and return XML document
    #
    # @return [String]
    def render_opml(list)
      document = Nokogiri::XML(list.load_list)
      feeds.each do |feed_url|
        node = "<outline xmlUrl='#{feed_url}' />\n"
        document.xpath("//outline[@text='Subscriptions']").last.add_child node
      end
      formatted_no_decl = Nokogiri::XML::Node::SaveOptions::FORMAT +
                          Nokogiri::XML::Node::SaveOptions::NO_DECLARATION
      document.to_xml(encoding: 'utf-8', save_with: formatted_no_decl)
    end
  end
end
