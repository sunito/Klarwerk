class Quelle < ActiveRecord::Base
  has_many :messpunkte
  belongs_to :einheit
  
  def aktiv
    status && status > 0
  end
  
  def aktiv=(neuer_aktivwert)
    self.status = neuer_aktivwert ? 1 : 0
  end

  def self.alle_aktiven
    all.select(&:aktiv).sort_by(&:adresse)
  end
  
  def self.auto_quelle(adresse, wert=nil)
    q = Quelle.find_by_adresse(adresse)
    if not q then
      q = Quelle.new
      q.adresse = adresse
      q.name = "Messgroesze fuer #{adresse}"
      q.beschreibung = q.name + ", generiert am #{Time.now}."
      q.variablen_art = "unbekannt"
      q.einheit = Einheit.auto_einheit(wert)
      q.status = 0
      q.save!
    end
    q
  end    

end
