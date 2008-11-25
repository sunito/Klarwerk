class Zeit < ActiveRecord::Base
  has_many :diagramme

  def self.finde_oder_neu(bis, dauer)
    erg = self.find_by_bis_and_dauer(bis, dauer)
    if not erg then
      erg = Zeit.new(bis, dauer)
    end
    erg
  end

end
