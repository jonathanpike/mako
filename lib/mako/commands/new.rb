require 'fileutils'

module Mako
  class New
    # Copies template files stored in ../lib/templates to specified directory.
    # If the directory specified doesn't exist, it will be created.
    # If no directory is specified, it defaults to the current directory.
    def self.perform(args)
      location = args.size < 1 ? Dir.pwd : File.expand_path(args.join(' '), Dir.pwd)
      create_dir(File.basename(location)) if location != Dir.pwd && File.directory?(location)
      copy_templates(location)
      Mako.logger.info "Created new Mako installation in #{location}"
    end

    # @private
    # Copies source templates to specified path.
    def self.copy_templates(path)
      FileUtils.cp_r "#{Mako.config.source_templates}/.", path
    end

    # If the directory does not exist, create the specified directory.
    def self.create_dir(path)
      FileUtils.mkdir path
    end
  end
end
