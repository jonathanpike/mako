require 'yaml'

module Mako
  class Configuration
    DEFAULT_CONFIGURATION = { 'source_templates' => File.expand_path('../templates', File.dirname(__FILE__)),
                              'destination' => File.expand_path('site/', Dir.pwd),
                              'theme' => 'simple',
                              'sanitize_images' => true,
                              'config_file' => ''
                            }.freeze

    include FileOpenUtil

    # Loads default config file and attempts to merge in any user settings.
    # Creates a new instance of Mako::Configuration.
    #
    # @param [String]
    # @return [Mako::Configuration]
    def self.load(file)
      begin
        user_config_yaml = load_resource(file)
      rescue SystemCallError
        config = DEFAULT_CONFIGURATION
        return new(config)
      end
      user_config = YAML.load(user_config_yaml) || {}
      user_config['config_file'] = file
      config = DEFAULT_CONFIGURATION.merge(user_config)
      new(config)
    end

    attr_reader :source_templates, :theme, :destination, :sanitize_images,
                :config_file

    def initialize(args)
      @source_templates = args.fetch('source_templates')
      @theme = args.fetch('theme')
      @destination = args.fetch('destination')
      @sanitize_images = args.fetch('sanitize_images')
      @config_file = args.fetch('config_file')
    end
  end
end
