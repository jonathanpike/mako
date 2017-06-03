module Mako
  class SassRenderer
    include FileOpenUtil

    attr_reader :template

    def initialize(args)
      @template = args.fetch(:template)
    end

    # Wrapper for Sass::Engine.  Creates new Sass::Engine instance with main
    # Sass file and renders it.
    #
    # @return [String]
    def render
      Sass::Engine.new(load_resource(template), syntax: :scss,
                                                load_paths: [File.expand_path('../lib/templates/')],
                                                style: :compressed).render
    end

    # Default file name for rendererd file.
    #
    # @return [String]
    def file_path
      'main.css'
    end
  end
end
