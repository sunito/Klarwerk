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

  def self.die_aktuelle
    #stub
    finde_oder_neu(nil, 12.hours)
  end

end
