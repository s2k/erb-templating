require 'minitest'
require 'minitest/autorun'
require_relative './../lib/support'

class TestRendering < Minitest::Test
  def test_render_existing_key
    assert_equal "Render 'this' text", render("Render '<%= test_key %>' text", {test_key: "this"})
    assert_equal "Render 'that' text", render("Render '<%= test_key %>' text", {test_key: "that"})
  end

  def test_missing_key_causes_an_exception
    template_string = "Render '<%= test_key %>' text"
    config_values   = {}
    assert_raises(NameError) { render(template_string, config_values) }
  end
end
