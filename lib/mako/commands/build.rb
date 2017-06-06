module Mako
  class Build
    # Calls #build on Mako::Core.  This class stores knowledge of all of the
    # different component classes needed to build the site.
    #
    # @param [Array] args the following are accepted arguments:
    #                "--with-sass": builds with SassRenderer
    def self.perform(args)
      subscription_list = load_subscription_list
      if args.include? '--with-sass'
        Mako::Core.new(requester: FeedRequester,
                       constructor: FeedConstructor,
                       renderers: [HTMLRenderer,
                                   SassRenderer],
                       writer: Writer,
                       subscription_list: subscription_list).build
      else
        Mako::Core.new(requester: FeedRequester,
                       constructor: FeedConstructor,
                       renderers: [HTMLRenderer],
                       writer: Writer,
                       subscription_list: subscription_list).build
      end
    end

    def self.load_subscription_list
      path = File.expand_path(Dir.glob('subscriptions.*').first, Dir.pwd)
      Mako::SubscriptionListParser.new(list: path).parse
    end
  end
end
