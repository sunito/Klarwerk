class Zeit < ActiveRecord::Base
  has_many :diagramme

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

  def +(sekunden)
    Zeit.new
  end

  def weiter!
    if self.bis then
      self.dauer ||= 1.hour
      self.bis += self.dauer / 2
      self.bis = Time.now if self.bis > Time.now
    end
  end

  def zurueck!
    self.bis ||= Time.now
    self.dauer ||= 1.hour
    self.bis -= self.dauer / 2
  end



  @@zeit_aktuell = begin
    find(1)
  rescue
    @@zeit_aktuell = new
    @@zeit_aktuell.bis = nil
    @@zeit_aktuell.dauer = 12.hours
    @@zeit_aktuell.save!
    @@zeit_aktuell
  end

  def self.die_aktuelle
    #stub
    #self.class.find(1)
    @@zeit_aktuell
  end
  
  def self.die_aktuelle=(andere_zeit)
    if andere_zeit.is_a?(Zeit) then
      @@zeit_aktuell.bis = andere_zeit.bis
      @@zeit_aktuell.dauer = andere_zeit.dauer
    end
  end


end


