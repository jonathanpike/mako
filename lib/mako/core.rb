module Mako
  class Core
    include ERB::Util
    include ViewHelpers

    attr_reader :feeds, :requester, :constructor, :renderers, :writer,
                :subscription_list

    def initialize(args)
      @feeds = []
      @requester = args.fetch(:requester)
      @constructor = args.fetch(:constructor)
      @renderers = args.fetch(:renderers)
      @writer = args.fetch(:writer)
      @subscription_list = args.fetch(:subscription_list)
    end

    # Gets list of feed_urls, requests each of them and uses the constructor to
    # make Feed and Article objects, then calls to the renderers to render
    # the page and stylesheets.
    def build
      log_configuration_information

      if subscription_list.size < 1
        Mako.logger.warn 'No feeds were found in your subscriptions file. Please add feeds and try again.'
        return
      end

      log_time do
        request_and_build_feeds
        renderers.each do |renderer|
          writer.new(renderer: renderer,
                     destination: File.expand_path(renderer.file_path, Mako.config.destination)).write
        end
      end
    end

    # Returns the Binding of Core for the ERB renderer. Binding encapsulates the
    # execution context for the Core class, and makes all of the variables
    # and methods of Core available to the renderer.
    #
    # @return [Binding]
    def get_binding
      binding
    end

    private

    # @private
    # Prints configuration file, source, and destination directory to STDOUT.
    def log_configuration_information
      Mako.logger.info "Configuration File: #{Mako.config.config_file}"
      Mako.logger.info "Theme: #{Mako.config.theme}"
      Mako.logger.info "Destination: #{Mako.config.destination}"
    end

    # Provides build time logging information and writes it to STDOUT.
    def log_time
      Mako.logger.info 'Generating...'
      start_time = Time.now
      yield
      end_time = Time.now
      generation_time = ((end_time - start_time) / 60 * 100).round(3)
      Mako.logger.info "done in #{generation_time} seconds"
    end

    def request_and_build_feeds
      requesters = subscription_list.map { |feed_url| requester.new(feed_url: feed_url) }
      requesters.each do |feed_request|
        feed_response = feed_request.fetch
        if feed_request.ok?
          feeds << constructor.new(feed_data: feed_response.body,
                                   feed_url: feed_response.feed_url).parse_and_create
        end
      end
    end
  end
end