class SystemController < ApplicationController
  VOR_GOD = "unset RUBYOPT; export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/kw/bin:/home/kw/.rvm/bin; unset GEM_PATH GEM_HOME _ORIGINAL_GEM_PATH BUNDLE_BIN_PATH RUBYLIB"
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
    @dienste = DIENSTE[1,2].map do |dienst_name|
      ausschaltbar = true
      if NICHT_AUSSCHALTBAR.include? dienst_name
        ausschaltbar = false
      end
  	  status_abfrage_erg = "on"
#      god_ruby = "~/.rvm/rubies/ruby-2.2.1/bin/ruby"
      god_ruby = "/usr/bin/ruby1.8"
      god_ruby = "ruby"
#      god_anweis = "/home/kw/.rvm/gems/ruby-2.2.1/bin/god"
      god_anweis ="/usr/local/bin/god" 
      god_anweis ="god" 
      erg = nil
   #   erg = (`#{god_ruby} -e "p ENV"`)
      puts erg
   #   system "#{god_ruby} -e 'p ENV'"
#      system "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/kw/bin:/home/kw/.rvm/bin ;unset GEM_PATH GEM_HOME _ORIGINAL_GEM_PATH BUNDLE_BIN_PATH RUBYLIB RUBYOPT;env;ruby -e'p 42' "
      #system "unset RUBYOPT;env;ruby -e'p 42' "
      god_status = "xxx: down"
      puts `#{VOR_GOD} ;env ;#{god_ruby} -e'p 42'`
      #god_status = (`#{anweis_vorbereitung} ;#{god_ruby} #{god_anweis} status #{dienst_name}`)
      god_status = (`#{VOR_GOD} ;#{god_anweis} status #{dienst_name}`)
      god_status = god_status.split(':')[1]
      puts "STATUS von #{dienst_name} ########################################"
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
      `#{VOR_GOD} ;god start #{params[:dienst]}`
    end
    render :action => "datenverarbeiter.js.erb",  :layout => false
  end
  def ajax_dienst_neustart
    `#{VOR_GOD} ;god restart #{params[:dienst]}`
    render :action => "datenverarbeiter.js.erb",  :layout => false
  end
end
