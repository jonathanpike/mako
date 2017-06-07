# frozen_string_literal: true

module Mako
  class SubscriptionListParser
    include FileOpenUtil

    attr_reader :list

    def initialize(args)
      @list = args.fetch(:list)
    end

    # Parses OPML, JSON, or plain text documents and returns an Array of feed urls.
    #
    # @return [Array]
    def parse
      loaded_list = load_resource(list)
      case File.extname list
      when '.xml' || '.opml'
        Nokogiri::XML(loaded_list).xpath('//@xmlUrl').map(&:value)
      when '.json'
        JSON.parse(loaded_list)
      when '.txt'
        loaded_list.split("\n")
      end
    end
  end
end
