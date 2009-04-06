require 'test_helper'

class ZeitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_aktuelle
    assert Zeit.die_aktuelle
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer
    assert_equal nil, Zeit.die_aktuelle.bis

    Zeit.die_aktuelle.zurueck!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Rückwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_in_delta Time.now - DAUER_STANDARD/4, Zeit.die_aktuelle.bis, 10.seconds, "halbe Dauer zurueck"

    bis_vorher = Zeit.die_aktuelle.bis
    Zeit.die_aktuelle.weiter!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Vorwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_equal bis_vorher + DAUER_STANDARD/4, Zeit.die_aktuelle.bis, "halbe Dauer weiter"

    Zeit.die_aktuelle.kuerzer!
    assert_equal DAUER_STANDARD/2, Zeit.die_aktuelle.dauer, "Dauer reduziert sich auf 6 Std bei kuerzer!"

    Zeit.die_aktuelle.laenger!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer wieder bei 12 Std bei laenger!"


    Zeit.die_aktuelle.dauer = DAUER_STANDARD - 1.hours
    Zeit.die_aktuelle.laenger!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer rastet ein bei laenger!"

    Zeit.die_aktuelle.dauer = DAUER_EINRASTPUNKTE_AUFWAERTS.first
    Zeit.die_aktuelle.kuerzer!
    assert_equal DAUER_EINRASTPUNKTE_AUFWAERTS.first, Zeit.die_aktuelle.dauer, "Dauer schlägt unten an bei kuerzer!"

    Zeit.die_aktuelle.dauer = DAUER_EINRASTPUNKTE_AUFWAERTS.first / 1000
    Zeit.die_aktuelle.kuerzer!
    assert_equal DAUER_EINRASTPUNKTE_AUFWAERTS.first, Zeit.die_aktuelle.dauer, "Dauer geht auf den Anfang hoch bei zu kleinen Werten bei kuerzer!"

  end

  def test_dauer_lesbar
    Zeit.die_aktuelle.dauer = 12.hours
    assert Zeit.die_aktuelle
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer
    assert_equal "5 min", dauer_lesbar(300)
    assert_equal "12 Std.", Zeit.die_aktuelle.dauer_lesbar
  end
end
