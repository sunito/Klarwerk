class Diaque < ActiveRecord::Base
  attr_accessible :farbe_mit_raute

  belongs_to :quelle
  belongs_to :diagramm
	def farbe_mit_raute= neue_farbe
    	self.farbe = neue_farbe[1,6]
  	end

  	def farbe_mit_raute
    	"#" + self.farbe
 	end
  	def anzuzeigende_farbe
  		farbe || quelle.farbe
  	end

end
