class Diaque < ActiveRecord::Base
  belongs_to :quelle
  belongs_to :diagramm

  def anzuzeigende_farbe
  	farbe || quelle.farbe
  end

end
