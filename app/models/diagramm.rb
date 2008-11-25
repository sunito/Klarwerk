class Diagramm < ActiveRecord::Base
  has_many :diaquen
  has_many :quellen, :through => :diaquen
  belongs_to :zeit

  def before_save
    self.zeit = Zeit.finde_oder_neu(bis, dauer)
  end

  def quellen_zuweiser
    Quelle.find(:all).map{|q| q.id}.last
  end  
  
  def quellen_zuweiser=(neue_quell_id)
    neue_quelle = Quelle.find(neue_quell_id)
    quellen << neue_quelle unless quellen.include? neue_quelle
  end

  def bis
    @bis = zeit ? zeit.bis : @bis
  end

  def bis=(wert)
    @bis = wert
  end

  def dauer
    @dauer = zeit ? zeit.dauer : @dauer
  end

  def dauer=(wert)
    @dauer = wert
  end
end
 