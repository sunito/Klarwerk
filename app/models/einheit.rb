class Einheit < ActiveRecord::Base
  has_many :quellen

  def hub
    max - min
  end

  def groeszenordnung
    10   **   ((hub / 3.0).to_i.to_s.size - 1)
  end

  def schritt_fuer_anzahl(anzahl)
    return 1 unless anzahl > 0
    erg_exakt = hub / anzahl
    grob = groeszenordnung / 10.0
    ( erg_exakt / grob).round * grob
  end
  
  def Einheit.auto_einheit(wert)
    return find(:first)
    return find(:first) if not wert
    if wert == "0" or wert == "1" then
      einheit_01 = find_by_min_and_max(0, 1)
      if false and not einheit_01 then
        einheit_01 = new
        einheit_01.name = "0 -- 1"
        einheit_01.save!
        
        einheit_01.min = 0
        einheit_01.save!
        einheit_01.max = 1
        einheit_01.save!
        einheit_01.beschreibung = "automatisch generierte Null-Eins-Einheit"
        einheit_01.save!
      end
      einheit_01
    else
      zahl = wert.to_f
      einheit = find(:all).to_a.find {|e| (e.min||0) < zahl and (!e.max or zahl < e.max) }
      if false and not einheit then
        einheit = new
        einheit.name = "0 -- 1"
        einheit.min = 0
        einheit.max = (zahl*2).round
        einheit.beschreibung = "automatisch generierte Einheit"
        einheit.save!
      end
      einheit
    end      
  end      
end
