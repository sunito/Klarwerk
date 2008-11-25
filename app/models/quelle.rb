class Quelle < ActiveRecord::Base
  has_many :messpunkte
  belongs_to :einheit
  
  def aktiv
    status && status > 0
  end
  
  def aktiv=(neuer_aktivwert)
    if neuer_aktivwert
      status = 1
    else
      status =0
    end
  end

end
