class Einheit < ActiveRecord::Base
  has_many :quellen

  def hub
    max - min
  end

  def groeszenordnung
    10   **   ((hub / 3.0).to_i.to_s.size - 1)
  end

  def schritt_fuer_anzahl(anzahl)
    erg_exakt = hub / anzahl
    grob = groeszenordnung / 10
    ( erg_exakt / grob).round * grob
  end

end
