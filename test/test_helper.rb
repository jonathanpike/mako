# frozen_string_literal: true

require_relative '../lib/mako'
require 'minitest/autorun'
require 'minitest/mock'
require 'vcr'
require 'coveralls'

Coveralls.wear!

VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :faraday
end

module TestHelper
  def self.xml_feed
    @xml_feed ||= File.open(File.expand_path('xml_feed.txt', File.join(File.dirname(__FILE__), 'helper_files')), 'rb', &:read)
  end

  def self.json_feed
    @json_feed ||= File.open(File.expand_path('json_feed.txt', File.join(File.dirname(__FILE__), 'helper_files')), 'rb', &:read)
  end

  def self.not_xml
    @not_xml ||= File.open(File.expand_path('not_xml.txt', File.join(File.dirname(__FILE__), 'helper_files')), 'rb', &:read)
  end
end
