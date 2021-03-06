class Diagramm < ActiveRecord::Base
  has_many :diaquen
  attr_accessible :name, :beschreibung
  attr_accessible :diaquen_attributes
  accepts_nested_attributes_for :diaquen
  
  has_many :quellen, :through => :diaquen

  #has_many :einheiten, :through => :quellen, :source => :einheit
  belongs_to :zeit

  #, :mapping => [%w(balance amount), %w(currency currency)]
  composed_of :bis, :class_name => "DateTime"

#  do |params|
 #   DateTime.new [1..5].map {|i| params["bis#{i}i"]}
  #end

  alias :diaquen_vorher= :diaquen=
  def diaquen=(neu)
    p ["diaquen=", neu]
    self.diaquen_vorher=(neu)
  end

  alias :quelleids_vorher= :quelle_ids=

  def quelle_ids=(neu)
    p ["quelleids=", neu]
    self.quelleids_vorher=(neu)
  end



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
    Quelle.alle_aktiven.map{|q| q.id}.last
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

  def einheiten_mit_diaquen
    Hash.new.tap do |erg|
      diaquen.each do |dq|
        einheit = dq.quelle && dq.quelle.einheit
        erg[einheit] ||= []
        erg[einheit] << dq
      end
    end
  end

  def einheiten
    einheiten_mit_diaquen.sort_by do |einheit, diaquen|
      [-einheit.max, -diaquen.size]
    end.transpose.first || []
  end

  def haupt_einheit    
    einheiten[0]
  end

  def zweite_skala?
    einheiten.size > 1
  end
end
 
__END__
sortierte_einheiten =     
    if sortierte_einheiten.empty? then
      sortierte_einheiten
    else
      []
    end
