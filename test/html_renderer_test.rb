require_relative 'test_helper'

class HTMLRendererTest < Minitest::Test
  def setup
    @template = File.expand_path('helper_files/simple.html.erb', File.dirname(__FILE__))
  end

  def test_render_returns_string
    binding_klass = Minitest::Mock.new
    binding_klass.expect :get_binding, binding_klass.send(:binding)
    binding_klass.expect :today, Time.now.to_s
    binding_klass.expect :last_updated, Time.now.to_s

    renderer = Mako::HTMLRenderer.new(template: @template, binding: binding_klass)
    rendered = renderer.render
    assert_instance_of String, rendered

    binding_klass.verify
  end
end
