module Mako
  class HTMLRenderer
    include FileOpenUtil

    attr_reader :template, :binding, :feed_template

    def initialize(args)
      @template = args.fetch(:template)
      @binding = args.fetch(:binding)
      @feed_template = File.expand_path('layouts/_feed_container.html.erb', __FILE__)
    end

    # Wrapper for ERB renderer. Creates new ERB instance with view template
    # and renders it with binding from core.
    #
    # @return [String]
    def render
      ERB.new(load_resource(template)).result(binding.get_binding) do
        ERB.new(load_resource(feed_template)).result(binding.get_binding)
      end
    end

    # Default file name for rendererd file.
    #
    # @return [String]
    def file_path
      'index.html'
    end
  end
end
