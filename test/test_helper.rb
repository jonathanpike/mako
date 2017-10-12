# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!
require_relative '../lib/mako'
require 'minitest/autorun'
require 'minitest/mock'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'test/vcr_cassettes'
  config.hook_into :webmock
end

module TestHelper
  def self.xml_feed
    @xml_feed ||= File.open(File.expand_path('xml_feed.txt', File.join(__dir__, 'helper_files')), 'rb', &:read)
  end

  def self.json_feed
    @json_feed ||= File.open(File.expand_path('json_feed.txt', File.join(__dir__, 'helper_files')), 'rb', &:read)
  end

  def self.not_xml
    @not_xml ||= File.open(File.expand_path('not_xml.txt', File.join(__dir__, 'helper_files')), 'rb', &:read)
  end
end
