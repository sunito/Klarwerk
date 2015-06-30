class DiagrammeController < ApplicationController
  OFC = self
  require 'net/http'
  require 'uri'
  require 'open-uri'
  require 'rubygems'
  #require 'pry'
  def akt_zeit

    session[:akt_zeit] ||= Zeit.die_aktuelle
  end

  # GET /diagramme
  # GET /diagramme.xml
  def index
    session[:akt_zeit] = Zeit::STANDARDZEIT
    session[:akt_zeit].bis = Time.at(Messpunkt.last.sekzeit)
    # test 
    @diagramme = Diagramm.find(:all)
  end

  def xx_erstelle_graph
    hoehe = 600
    @graph = open_flash_chart_object( "80%", hoehe, url_for( :action => 'show', :format => :json ) )
    if @diagramm.zweite_skala? then
      @zusatz_skala = open_flash_chart_object( 55, hoehe, url_for( :action => 'show', :format => :skala ) )
    end

  end

  def xx_chart_update
    @diagramm = Diagramm.find(params[:id])
    if (params[:farbe] != nil)
      @farbe = params[:farbe]
      diaque = @diagramm.diaquen.first
      diaque.farbe = @farbe
      diaque.save!
    end     
    render_chart_update
  end

  #private
  def render_chart_update
    ##chart_kurven
    highchart_kurven
    puts JSON.pretty_generate(@highchart)
    #render :action => "update_zeit.rjs", :layout => false
    render :action => "grafik_aktualisierer.js.erb", :layout => false
  end

  public
  
  def verschieben
    if params[:anfang] == "links" then
      akt_zeit.zurueck!
    elsif params[:anfang] == "rechts" then 
      akt_zeit.weiter!
    elsif params[:anfang] == "anfang" then 
      session[:akt_zeit].bis = Time.at((Messpunkt.find(1).sekzeit)+3600*12)
    else 
      session[:akt_zeit].bis = Time.now
    end
    render_chart_update
  end


  #def anfangszeit
   # p :EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
    #if params[:anfang] then
     # puts  ":anfang=" + params[:anfang].inspect
      #session[:akt_zeit].bis = Time.at((Messpunkt.find(1).sekzeit)+3600*12)
    #else
      #puts  ":anfang=false" + params[:anfang].inspect
      #session[:akt_zeit].bis = Time.now
    #end
    #render_chart_update
  #end

  def dauer
    akt_zeit.dauer = params[:dauer]
    #render :inline => @chart
    p [:dauer, params[:dauer]]
    #render :template => "update_zeit"
    render_chart_update
  end

  def zoom_out
    akt_zeit.laenger!
    #render :inline => @chart
    p :zoomout
    #render :template => "update_zeit"
    render_chart_update
  end

  def zoom_in
    akt_zeit.kuerzer!
    render_chart_update
  end

  def highchart_kurven
    #self.extend OFC
    @diagramm = Diagramm.find(params[:id])
    emd = @diagramm.einheiten_mit_diaquen
    #@chart = OFC::OpenFlashChart.new
    p :EMDDDDDDDD
    p emd.size
    p emd
    @highchart = LazyHighCharts::HighChart.new('graph') do |hc|
      hc.title :text => @diagramm.name #, :style => "{font-size: 30px;}"}

      y_achsen = []
      @diagramm.einheiten.each do |einheit|

        point_start = nil

        p emd[einheit].size
        p einheit
        p emd[einheit]
        emd[einheit].each_with_index do |diaque, dia_idx|
          raise "diaque ist ein Array!!!!!!!!!" if diaque.respond_to? :each
          #diaquen.each_with_index do |diaque, idx|

          dual_streck_fkt = if einheit.name =~ /aus.*ein/i
            #einh = @diagramm.haupt_einheit
            einh = einheit
            max = einh.max
            min = einh.min
            binaer_anzahl = 10
            #binaer_hoehe = 1.0 / binaer_anzahl/ 2
            proc {|z| z && min + (max-min) * (binaer_anzahl - dia_idx - 0.7 + (z>0 ? 0.5 : 0)  )  / binaer_anzahl } 
          end
          kurve = Kurve.new(diaque, akt_zeit)
          p kurve.linien_daten  
          point_start ||= kurve.von.to_i*1000
          aufgefuellte_linien_daten = kurve.linien_daten_aufgefuellt.map do |wert|
            dual_streck_fkt ? dual_streck_fkt[wert] : wert
          end
          hc.series ({     
            type: 'line'   , 
            name: "#{dia_idx}" + diaque.quelle.name, 
            color: "#" + diaque.anzuzeigende_farbe,
            point_start: point_start, 
            point_interval: kurve.x_schritt * 1000, 
            y_axis: y_achsen.size,
            data: aufgefuellte_linien_daten
          })
        end
        p :vor_ende
        p einheit
        achse_disabled = (einheit.name =~ /aus.*ein/i)
        #if einheit.beschreibung == "Aus und Ein (!bin!)" #Bei binären Einheiten keine neue y-Achse hinzufügen, außer es ist die einzige
        y_achsen << {
          labels: {enabled: (not achse_disabled), format: "{value} #{einheit.name}"}, 
          min: einheit.min, 
          max: einheit.max, 
          title: {text: (achse_disabled ? nil : einheit.beschreibung)}, 
          opposite: (y_achsen.size > 0)
        }
      end
      hc.x_axis type: 'datetime'
      hc.y_axis y_achsen
      hc.legend ({
        align: 'left',
        verticalAlign: 'top',
        floating: true,
        x: 90
      })
      p :y_achsen
      p y_achsen
    end      
  end

  def showfix
    session[:akt_zeit] = Zeit::STANDARDZEIT
    redirect_to :action => "show"
  end
  

  # GET /diagramme/1
  # GET /diagramme/1.xml
  def show
    akt_zeit
    #chart_kurven
    highchart_kurven
    init_diaquenauswahl
    # macht folgende Zeile �berfl�ssig
    #@diagramm = Diagramm.find(params[:id])
    @titelzeile = @diagramm.name + " - KabDiag"
    respond_to do |format|
      format.html {
      }
      format.json {
        p @chart
        render :inline => @chart.render  #, :layout => false
      }
    end
  end

  # GET /diagramme/new
  # GET /diagramme/new.xml
  def new
    @diagramm = Diagramm.new
    init_diaquenauswahl

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diagramm }
    end
  end

  # GET /diagramme/1/edit
  def edit
    @diagramm = Diagramm.find(params[:id])
    init_diaquenauswahl
  end

  def init_diaquenauswahl
    #session[:diaquenauswahl_original] = session[:diaquenauswahl]
    init_diaquenauswahl_fuer_view
  end

  # POST /diagramme
  # POST /diagramme.xml
  def create
    @diagramm = Diagramm.new(params[:diagramm])

    respond_to do |format|
      if @diagramm.save
        flash[:notice] = 'Diagramm wurde erstellt.'
        format.html { redirect_to(edit_diagramm_path(@diagramm)) }
        format.xml  { render :xml => @diagramm, :status => :created, :location => @diagramm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diagramm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diagramme/1
  # PUT /diagramme/1.xml
  def update
    @diagramm = Diagramm.find(params[:id])

    session[:diaquenauswahl] = session[:diaquenauswahl_original] if params[:abbruch]
    respond_to do |format|
      p [:XXXXXXXXXXXX, 'params[:diagramm]', params[:diagramm]]
      # @diagramm.quelle_ids = (session[:quellenauswahl])
      #session[:diaquenauswahl].each {|diaque| diaque.save!}
      #@diagramm.diaquen = session[:diaquenauswahl]
      if @diagramm.update_attributes(params[:diagramm])
        flash[:notice] = 'Diagramm wurde gespeichert.'
        format.html { redirect_to(@diagramm) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diagramm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diagramme/1
  # DELETE /diagramme/1.xml
  def destroy
    @diagramm = Diagramm.find(params[:id])
    @diagramm.destroy

    respond_to do |format|
      format.html { redirect_to(diagramme_url) }
      format.xml  { head :ok }
    end
  end

  def init_diaquenauswahl_fuer_view
    @freie_quellen = Quelle.alle_aktiven - @diagramm.quellen
    @ausgewaehlte_diaquen = @diagramm.diaquen
  end

  def quelle_rein
    @diagramm = Diagramm.find(params[:id])
    quelle = Quelle.find params[:quelle_id].to_i
    @diagramm.quellen << quelle
    @diagramm.save!
    diaque = @diagramm.diaquen.find_by_quelle_id(quelle.id)
    diaque.farbe ||= quelle.farbe
    diaque.save!
    render_quellenselektor
  end

  def quelle_raus
    @diagramm = Diagramm.find(params[:id])
    quelle = Quelle.find params[:quelle_id].to_i
    @diagramm.quellen.delete quelle
    @diagramm.save!
    render_quellenselektor
  end

  def render_quellenselektor
    #render_chart_update # doppeltes Rendern funktioniert nicht!
    init_diaquenauswahl_fuer_view
    render :partial => "quellen_auswahl_listen", :layout => false
  end


  def xxxxx_quellenfarbe
    @diagramm = Diagramm.find(params[:id])
    quelle_id = params[:quelle_id]
    farbe = params[:farbe]
    if farbe then
      session[:quellenfarben] += { quelle_id => farbe }
    else
      session[:quellenfarben].delete(quelle_id)
    end
    render :layout => false
    # oder:
    # render :action => "farben_bereich", :layout => false
  end

end
