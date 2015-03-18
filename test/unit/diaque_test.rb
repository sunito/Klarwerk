require 'test_helper'

class DiaqueTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_anzuzeigende_farbe
    assert_equal "001122", diaquen(:one).anzuzeigende_farbe, "direkt gespeichert"
    assert_equal "2233FF", diaquen(:two).anzuzeigende_farbe, "via Quelle"
  end
end
