class Diagramm < ActiveRecord::Base
  has_many :diaquen
  accepts_nested_attributes_for :diaquen

  has_many :quellen, :through => :diaquen
  #has_many :einheiten, :through => :quellen, :source => :einheit
  belongs_to :zeit
  composed_of :bis, :class_name => "DateTime"
  attr_accessor :bis, :dauer


  def after_initialize
    if zeit then
      @bis = zeit.bis
      @dauer = zeit.dauer       
    end
  end

  def before_save
    self.zeit = Zeit.finde_oder_neu(bis, dauer)
  end

  def einheiten_mit_diaquen
    returning Hash.new do |erg|
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
