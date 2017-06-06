module Mako
  class SassRenderer
    include FileOpenUtil

    attr_reader :template

    def initialize(args)
      @template = File.expand_path(File.join('themes', "#{Mako.config.theme}.scss"), Dir.pwd)
    end

    # Wrapper for Sass::Engine.  Creates new Sass::Engine instance with main
    # Sass file and renders it.
    #
    # @return [String]
    def render
      Sass::Engine.new(load_resource(template), syntax: :scss,
                                                load_paths: [File.expand_path('themes/', Dir.pwd)],
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
