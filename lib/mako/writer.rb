# frozen_string_literal: true

module Mako
  class Writer
    attr_reader :renderer, :destination

    def initialize(args)
      @renderer = args.fetch(:renderer)
      @destination = args.fetch(:destination)
    end

    def write
      File.open(destination, 'w+', encoding: 'utf-8') do |f|
        f.write(renderer.render)
      end
    end
  end
end
