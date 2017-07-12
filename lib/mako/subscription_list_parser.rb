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
      case File.extname list
      when '.xml' || '.opml'
        Nokogiri::XML(load_list).xpath('//@xmlUrl').map(&:value)
      when '.json'
        JSON.parse(load_list)
      when '.txt'
        load_list.split("\n")
      end
    end

    # Load the subscription list file
    #
    # @return [String]
    def load_list
      load_resource(list)
    end
  end
end
