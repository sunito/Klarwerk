require 'test_helper'

class DiagrammTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :diagramme
  fixtures :quellen
  fixtures :einheiten

  def setup
    @prozent = Einheit.find_by_name("Prozent")
    assert @prozent
    @quellen_db = Quelle.find(:all)
  end

  def test_truth
    assert_equal 2, @quellen_db.size
    q1, q2 = @quellen_db

    q1.einheit = @prozent
    q1.save!

    dias = Diagramm.find(:all)
    assert_equal 2, dias.size
    d1, d2 = dias
    assert_equal diagramme(:one).name, d1.name

    assert q1.name != q2.name

    d1.quellen_zuweiser = q1
    d1.save!

    q2.einheit = @prozent
    q2.save!

    assert_equal 1, d1.quellen.size
    assert_equal q1.name, d1.quellen.first.name

    assert_equal 1, d1.einheiten.size
    assert_equal @prozent.name, d1.einheiten.first.name

    d1.quellen_zuweiser = q2
    d1.save!

    assert_equal 2, d1.quellen.size
    assert_equal q2.name, d1.quellen.first.name

    assert_equal 1, d1.einheiten.size
    assert_equal @prozent.name, d1.einheiten.first.name

    deny d1.zweite_skala?

  end
end
