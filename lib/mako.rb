# frozen_string_literal: true

require 'time'
require 'erb'
require 'logger'
require 'httparty'
require 'feedjira'
require 'nokogiri'
require 'json'
require 'sass'

require_relative 'mako/core_ext'
require_relative 'mako/errors'
require_relative 'mako/file_open_util'
require_relative 'mako/mako_logger'
require_relative 'mako/view_helpers'
require_relative 'mako/configuration'
require_relative 'mako/subscription_list_parser'
require_relative 'mako/subscription_list_writer'
require_relative 'mako/feed'
require_relative 'mako/article'
require_relative 'mako/feed_requester'
require_relative 'mako/feed_constructor'
require_relative 'mako/feed_finder'
require_relative 'mako/html_renderer'
require_relative 'mako/sass_renderer'
require_relative 'mako/writer'
require_relative 'mako/core'
require_relative 'mako/cli'

module Mako
  def self.logger
    @logger ||= MakoLogger.new(STDOUT)
  end

  def self.config
    @config ||= Configuration.load(File.expand_path('config.yaml', Dir.pwd))
  end

  def self.errors
    @errors ||= Errors.new
  end
end
