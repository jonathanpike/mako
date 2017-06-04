require 'fileutils'

module Mako
  class New
    # Copies template files stored in ../lib/templates to specified directory.
    # If no directory is specified, it defaults to the current directory.
    def self.perform(args)
      location = args.size < 1 ? Dir.pwd : File.expand_path(args.join(' '), Dir.pwd)
      copy_templates(location)
      Mako.logger.info "Created new Mako instalation in #{location}"
    end

    private

    def copy_templates(path)
      FileUtils.cp_r Mako.config.source_templates, path
    end
  end
end
