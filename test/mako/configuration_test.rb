# frozen_string_literal: true

require_relative '../test_helper'

class ConfigurationTest < Minitest::Test
  def test_works_without_configuration_file
    config = Mako::Configuration.load('')
    assert_instance_of Mako::Configuration, config
    assert_equal 'simple', config.theme
    assert config.sanitize_images
    assert_equal '', config.config_file
  end

  def test_works_with_configuration_file
    config_file = File.expand_path('../config.yaml', File.dirname(__FILE__))
    config = Mako::Configuration.load(config_file)
    assert_instance_of Mako::Configuration, config
    assert_equal 'complex', config.theme
    refute config.sanitize_images
    assert_equal config_file, config.config_file
  end
end
