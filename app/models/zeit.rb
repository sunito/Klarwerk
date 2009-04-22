
DAUER_EINRASTPUNKTE_ABWAERTS = [365, 182, 91, 61, 30, 21, 14, 7, 3, 2, 1].map(&:days) +
                      [12, 6, 3, 2, 1, 0.5].map(&:hours) #  {|std| std.hours }
DAUER_EINRASTPUNKTE_AUFWAERTS = DAUER_EINRASTPUNKTE_ABWAERTS.reverse

DAUER_EINRASTPUNKTE = DAUER_EINRASTPUNKTE_AUFWAERTS

DAUER_STANDARD = 12.hours

class Zeit < ActiveRecord::Base
  has_many :diagramme

  def biszeit
    bis || Time.now
  end
  def vonzeit
    biszeit - (dauer || 0)
  end

  def self.finde_oder_neu(bis, dauer)
    p ["finde_oder_neu bis,dauer=", bis, dauer]
    erg = self.find_by_bis_and_dauer(bis, dauer)
    if not erg then
      erg = Zeit.new
      erg.bis = bis
      erg.dauer = dauer
      erg.save!
    end
    p ["finde_oder_neu erg=", erg]
    erg
  end

private
  def next_einrastpunkt(wert, sortierte_punktefolge)
    vorletzter, letzter = sortierte_punktefolge[-2..-1]
    vergleichs_symbol = if (vorletzter < letzter) then :< else :> end
    sortierte_punktefolge.find do |punkt|
      wert.send(vergleichs_symbol, punkt) or
        punkt == letzter
    end
  end

public
#Es gibt jetzt die 4 Methoden: kuerzer!, laenger!, zurueck! und weiter!
#Alle modifizieren direkt das Zeit-Objekt (deshalb die Ausrufungszeichen)
#und zwar die ersten beiden ändern die Dauer (mit Einrastung)
#und die letzten beiden Methoden verschieben das Ende ("bis") um ein
#Viertel der Dauer (jedoch nicht über den jetzigen Zeitpunkt hinaus).
  def kuerzer!
    self.dauer = next_einrastpunkt(self.dauer, DAUER_EINRASTPUNKTE_ABWAERTS)
    save!
  end

  def laenger!
    self.dauer = next_einrastpunkt(self.dauer, DAUER_EINRASTPUNKTE_AUFWAERTS)
    save!
  end

  def weiter!
    if self.bis then
      self.dauer ||= 1.hour
      self.bis += self.dauer / 4
      self.bis = nil if self.bis > Time.now
      save!
    end
  end

  def zurueck!
    self.bis ||= Time.now
    self.dauer ||= 1.hour
    self.bis -= self.dauer / 4
    save!
  end

  STANDARDZEIT = begin
    find(0)
  rescue
    new
  end
  STANDARDZEIT.bis = nil
  STANDARDZEIT.dauer = DAUER_STANDARD
  STANDARDZEIT.save!

  begin
    @@zeit_aktuell = find(1)
  rescue
    @@zeit_aktuell = new
    self.die_aktuelle = STANDARDZEIT
  end

  def self.die_aktuelle
    @@zeit_aktuell
  end
  
  def self.die_aktuelle=(andere_zeit)
    case andere_zeit
    when Zeit then
      @@zeit_aktuell.bis = andere_zeit.bis
      @@zeit_aktuell.dauer = andere_zeit.dauer
    when Integer then
      @@zeit_aktuell.bis = nil
      @@zeit_aktuell.dauer = andere_zeit
    when Time then
      @@zeit_aktuell.bis = andere_zeit
      @@zeit_aktuell.dauer = DAUER_STANDARD
    else
      raise "Zeitangabe nicht erkannt. Typ:#{andere_zeit.class}, Wert:#{andere_zeit.inspect}"
    end
    @@zeit_aktuell.save!
  end
  def dauer_lesbar
    super(dauer)
  end

end

# Macht aus dauer (in Sekunden) einen lesbaren Strring
def dauer_lesbar(dauer)
  return "???" unless dauer
  if dauer < 1.hours then
    "#{dauer/1.minutes} min"
  elsif dauer < 24.hours then
    "#{dauer/1.hours} Std."
  else
    tage = dauer / 1.days
    case tage
    when 1 then "1 Tag"
    when 7 then "1 Woche"
    when 30..31 then "1 Monat"
    when 60..61 then "2 Monate"
    when 90..92 then "3 Monate"
    when 180..183 then "6 Monate"
    when 360..366 then "1 Jahr"
    else
      "#{tage} Tage"
    end
  end
end

