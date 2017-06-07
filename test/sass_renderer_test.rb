# frozen_string_literal: true

require_relative 'test_helper'

class SassRendererTest < Minitest::Test
  def setup
    @template = File.expand_path('helper_files/main.scss', File.dirname(__FILE__))
  end

  def test_render_returns_string
    renderer = Mako::SassRenderer.new(template: @template)
    rendered = renderer.render
    assert_instance_of String, rendered
  end
end
