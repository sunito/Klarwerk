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

end
