require 'test_helper'

class ZeitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_aktuelle
    assert Zeit.die_aktuelle
    assert_equal 12.hours, Zeit.die_aktuelle.dauer
    assert_equal nil, Zeit.die_aktuelle.bis

    Zeit.die_aktuelle.zurueck!
    assert_equal 12.hours, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Rückwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_in_delta Time.now - 12.hours/2, Zeit.die_aktuelle.bis, 10.seconds, "halbe Dauer zurueck"

    bis_vorher = Zeit.die_aktuelle.bis
    Zeit.die_aktuelle.weiter!
    assert_equal 12.hours, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Vorwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_equal bis_vorher + 12.hours/2, Zeit.die_aktuelle.bis, "halbe Dauer weiter"

  end
end
