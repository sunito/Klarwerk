class SystemController < ApplicationController
  NICHT_AUSSCHALTBAR = %w[
    server
    rails-server
  ]
  DIENSTE = %w[
    server
    rails-server
  	eibd-server
    werte-speicherer
    werte-system
    simple
  ]
  class Dienst < Struct.new(:name, :status, :ausschaltbar)
  end

  def index
  	@dienste = DIENSTE.map do |dienst_name|
      ausschaltbar = true
      if NICHT_AUSSCHALTBAR.include? dienst_name
        ausschaltbar = false
      end
  	  status_abfrage_erg = "on"
      god_status = (`god status #{dienst_name}`)
      god_status = god_status.split(':')[1]
      p god_status
      if god_status == nil
        dienst_status = false
      elsif god_status.include? "up"
        dienst_status = true
      elsif god_status.include? "unmonitored"
        dienst_status = false
      end
  	  Dienst.new(dienst_name, dienst_status, ausschaltbar)
  	end
  end

  def ajax_update
    p params[:action]
    if(params[:action] == "restart")
      `god restart #{params[:dienst]}`
    end
    p params[:dienst]
    god_dienste = `god status`.chomp("\n") 
    p god_dienste
    render :action => "datenverarbeiter.js.erb",  :layout => false, :locals => {:god_status => god_dienste}
  end
  def ajax_dienst_neustarten
    god_status = `god stop #{params[:dienst]}`
    render :action => "datenverarbeiter.js.erb",  :layout => false, :locals => {:god_status => god_status}
  end
  def get_status
    god_status = `god status #{params[:dienst]}`
  end
  def ajax_dienst_start_stop
    if `god status #{params[:dienst]}`.include? "up"
      p '#{params[:dienst]} wird gestoppt'
      `god stop #{params[:dienst]}`
    else
      p '#{params[:dienst]} wird gestartet'
      `god start #{params[:dienst]}`
    end
    render :action => "datenverarbeiter.js.erb",  :layout => false
  end
  def ajax_dienst_neustart
    `god restart #{params[:dienst]}`
    render :action => "datenverarbeiter.js.erb",  :layout => false
  end
end
