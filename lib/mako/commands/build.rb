module Mako
  class Build
    # Calls #build on Mako::Core.  This class stores knowledge of all of the
    # different component classes needed to build the site.
    #
    # @param [Array] args the following are accepted arguments:
    #                "--with-sass": builds with SassRenderer
    def self.perform(args)
      subscription_list = load_subscription_list
      html_template = File.expand_path(File.join('themes', "#{Mako.config.theme}.html.erb"), Dir.pwd)
      if args.include? '--with-sass'
        sass_template = File.expand_path(File.join('themes', "#{Mako.config.theme}.scss"), Dir.pwd)
        Mako::Core.new(requester: FeedRequester,
                       constructor: FeedConstructor,
                       renderers: [HTMLRenderer.new(template: html_template, binding: self),
                                   SassRenderer.new(template: sass_template)],
                       writer: Writer,
                       subscription_list: subscription_list).build
      else
        Mako::Core.new(requester: FeedRequester,
                       constructor: FeedConstructor,
                       renderers: [HTMLRenderer.new(template: html_template, binding: self)],
                       writer: Writer,
                       subscription_list: subscription_list).build
      end
    end

    def self.load_subscription_list
      Mako::SubscriptionListParser.new(Mako.config.subscription_list).parse
    end
  end
end