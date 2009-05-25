require 'test_helper'

class MesspunktTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  #fixtures :messpunkte
  def test_zeit
    z = Messpunkt.new
    t = Time.now
    z.zeit = t
    assert_equal t.to_i, z.sekzeit
    #assert_equal 1, @one.zeit
  end
end
