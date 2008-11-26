class Diagramm < ActiveRecord::Base
  has_many :diaquen
  has_many :quellen, :through => :diaquen
  belongs_to :zeit

  #, :mapping => [%w(balance amount), %w(currency currency)]
  composed_of :bis, :class_name => "DateTime"

#  do |params|
 #   DateTime.new [1..5].map {|i| params["bis#{i}i"]}
  #end

  def after_initialize
    if zeit then
      @bis = zeit.bis
      @dauer = zeit.dauer       
    end
  end

  def before_save
    self.zeit = Zeit.finde_oder_neu(bis, dauer)
    p ["before_save zeit=", self.zeit]
  end

  def quellen_zuweiser
    Quelle.find(:all).map{|q| q.id}.last
  end  
  
  def quellen_zuweiser=(neue_quell_id)
    neue_quelle = Quelle.find(neue_quell_id)
    quellen << neue_quelle unless quellen.include? neue_quelle
  end

  def bis
    @bis
  end

  def bis=(wert)
    p "############# bis-wert: #{wert}"
    @bis = wert
  end

  def dauer
    @dauer 
  end

  def dauer=(wert)
    @dauer = wert
  end
end
 