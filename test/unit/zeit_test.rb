require 'test_helper'

#!# Diese Zeitmodellierung mag funktionieren, schön aber ist sie nicht!

class ZeitTest < ActiveSupport::TestCase
  def setup

  end

  def test_biszeit
    assert_equal nil, Zeit.die_aktuelle.bis, "die_aktuelle Zeit hat bis-Wert =nil"
    assert_equal Time.now, Zeit.die_aktuelle.biszeit, "biszeit == Time.now"    
    assert_equal nil, Zeit.die_aktuelle.bis, "nach Aufruf von Zeit#biszeit ist der bis-Wert immernoch nil"
  end


  def xx_test_aktuelle
    assert Zeit.die_aktuelle
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer
    assert_equal nil, Zeit.die_aktuelle.bis

    Zeit.die_aktuelle.zurueck!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Rückwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_in_delta Time.now - DAUER_STANDARD/4, Zeit.die_aktuelle.bis, 10.seconds, "viertel Dauer zurueck"

    bis_vorher = Zeit.die_aktuelle.bis
    Zeit.die_aktuelle.weiter!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Vorwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_equal bis_vorher + DAUER_STANDARD/4, Zeit.die_aktuelle.bis, "Viertel Dauer weiter"

    zeit_bis_vorher = Zeit.die_aktuelle.bis

    Zeit.die_aktuelle.zurueck!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Rückwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_equal zeit_bis_vorher - DAUER_STANDARD/4, Zeit.die_aktuelle.bis, "exakt viertel Dauer zurueck"

    Zeit.die_aktuelle.zurueck!
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer, "Dauer bleibt gleich bei Rückwärtsschritt"
    assert Zeit.die_aktuelle.bis
    assert_equal zeit_bis_vorher - DAUER_STANDARD/2, Zeit.die_aktuelle.bis, "zweimal viertel Dauer zurueck"

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

  def test_zurueck
  end

  def test_dauer_lesbar
    Zeit.die_aktuelle.dauer = 12.hours
    assert Zeit.die_aktuelle
    assert_equal DAUER_STANDARD, Zeit.die_aktuelle.dauer
    assert_equal "5 min", dauer_lesbar(300)
    assert_equal "12 Std.", Zeit.die_aktuelle.dauer_lesbar
  end
end
