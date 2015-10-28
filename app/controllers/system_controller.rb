class SystemController < ApplicationController
  DIENSTE = %w[
    server
    rails-server
  	eibd-server
    werte-speicherer
    werte-system
  ]
  class Dienst < Struct.new(:name, :status)
  end

  def index
  	@dienste = DIENSTE.map do |dienst_name|
  	  status_abfrage_erg = "on"
  	  dienst_status = (status_abfrage_erg == "on") 
  	  Dienst.new(dienst_name, dienst_status)
  	end
  end
end
