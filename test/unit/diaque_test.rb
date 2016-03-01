require 'test_helper'

class DiaqueTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_anzuzeigende_farbe
    assert_equal "001122", diaquen(:one).anzuzeigende_farbe, "direkt gespeichert"
    assert_equal "2233FF", diaquen(:two).anzuzeigende_farbe, "via Quelle"
  end

  def test_farbe_mit_raute
    assert_equal "#001122", diaquen(:one).farbe_mit_raute, "direkt gespeichert"
    assert_equal "#2233FF", diaquen(:two).farbe_mit_raute, "via Quelle"
  end
end
