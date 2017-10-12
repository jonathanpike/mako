# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mako/version'

Gem::Specification.new do |spec|
  spec.name          = 'mako_rss'
  spec.version       = Mako::VERSION
  spec.authors       = ['Jonathan Pike']
  spec.email         = ['jonathan.d.s.pike@gmail.com']

  spec.summary       = 'A static site feed reader'
  spec.homepage      = 'https://github.com/jonathanpike/mako'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.1'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'webmock', '~> 3.1'

  spec.add_runtime_dependency 'feedjira', '~> 2.0'
  spec.add_runtime_dependency 'httparty', '~> 0.15'
  spec.add_runtime_dependency 'nokogiri', '~> 1.8'
  spec.add_runtime_dependency 'sass', '~> 3.4'
end
