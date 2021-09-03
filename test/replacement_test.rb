require 'minitest'
require 'minitest/autorun'
require_relative './../lib/support'

class TestRendering < Minitest::Test
  def test_render_existing_key
    assert_equal "Render 'this' text", render("Render '<%= test_key %>' text", {test_key: "this"})
    assert_equal "Render 'that' text", render("Render '<%= test_key %>' text", {test_key: "that"})
  end

  def test_render_warning_for_missing_key

    expected_text   = "Render '#{MISSING_CONFIG_MARKER}' text"
    template_string = "Render '<%= test_key %>' text"
    config_values   = {}
    puts "ARGS for render method:"
    puts "expected_text   : #{expected_text}"
    puts "template_string : #{template_string}"
    puts "config_values   : #{config_values}"

    assert_equal expected_text, render(template_string, config_values)
  end
end
