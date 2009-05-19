class DiagrammeController < ApplicationController

  def akt_zeit
    session[:akt_zeit] ||= Zeit.die_aktuelle
  end

  # GET /diagramme
  # GET /diagramme.xml
  def index
    @diagramme = Diagramm.find(:all)
  end

  def xx_erstelle_graph
    hoehe = 600
    @graph = open_flash_chart_object( "80%", hoehe, url_for( :action => 'show', :format => :json ) )
    if @diagramm.zweite_skala? then
      @zusatz_skala = open_flash_chart_object( 55, hoehe, url_for( :action => 'show', :format => :skala ) )
    end

  end

  def links
    akt_zeit.zurueck!
    chart_kurven
    respond_to do |format|
      format.html {
        render :inline => open_flash_chart_object("100%",700, url_for(:format => "json"))
      }
      format.json {
        render :inline => @chart
      }
    end
  end

  def rechts
    akt_zeit.weiter!
    chart_kurven
    render :inline => @chart
  end

  def zoom_out
    akt_zeit.laenger!
    chart_kurven
    render :inline => @chart
  end

  def zoom_in
    akt_zeit.kuerzer!
    chart_kurven
    render :inline => @chart
  end

  def skala_chart
    p :skala
    #g = Graph.new
    chart = OpenFlashChart.new( "" ) do |g|
      #g.title(" ", '{font-size: 26px;}')
      linie = Line.new(2, '#FFFFFF')
      linie.key(" ", 10)
      [1,2].each do |w|
        linie.add_data_tip( w, "")
      end
      g.data_sets << linie

      g.set_x_labels(["00:00:00"])
      g.set_x_label_style(10,'#FFFFFF',2,5)
  #        g.set_inner_background '#FFFFFF'
      g.set_bg_color '#FFFFFF'

      @diamo = Kurve.new(@diagramm)

      skala = @diamo.skalen[1]
      p :skala => skala
      setze_y_achse(g, skala)
    end
    chart
  end

  def setze_skalen(chart)
    emq = @diagramm.einheiten_mit_diaquen

    einheit = @diagramm.haupt_einheit
    return if not einheit

    #self.extend OFC
#    y_legende = YLegend.new(einheit.name)
#    y_legende.set_style("{font-size: 20px; color: #{emq[einheit].first.farbe}}")
#    chart.y_legend = (y_legende)

    y_achse = OFC::YAxis.new
    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
    chart.y_axis = y_achse

    warn ["EZZZZZZZZZZZZZZZZZZZ444ZZZZZZZZZZZZZZZZZ", @diagramm.zweite_skala?]
    if @diagramm.zweite_skala? then
      zweite_einheit = @diagramm.einheiten[1]
      @streckungs_funktion = proc do |orig_wert|
        orig_wert && (einheit.min + (orig_wert - zweite_einheit.min) * einheit.hub / zweite_einheit.hub)
      end
      warn ["EZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ", einheit.hub, zweite_einheit.hub]
      warn @streckungs_funktion[100]
      
      y_legende = YLegendRight.new(einheit.name)
      #y_legende.set_style("{font-size: 20px; color: #778877}")
      #y_legende.style = '{font-size: 70px; color: #778877}'
      y_legende.set_style("{font-size: 20px; color: #{emq[zweite_einheit].first.farbe}}")
      chart.set_y_legend_right  y_legende
      #chart.set_y_legend_right( 'Free Ram (MB)' ,40 , '#164166' )


      y_achse = YAxisRight.new
      #y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
      # Workaraund
      g = zweite_einheit.groeszenordnung
      y_achse.set_range(zweite_einheit.min / g, zweite_einheit.max / g)
      #p [:abstand, abstand]
      chart.y_axis_right = y_achse

    end
  end

  def setze_xlabels #(kurve)
      #x_achse.set_range(kurve.von, kurve.bis, 60)

      x_labels = OFC::XAxisLabels.new
      #x_labels.style
      x_labels.set_vertical()
      x_labels.steps = 4
      x_labels.rotate = 270

      diff = akt_zeit.dauer
      require 'kurve'
      anz = GLOBAL_X_ANZAHL 
      x_labels.labels = (0..anz).map do |i|
        if i % 10 == 0
          text = (akt_zeit.vonzeit + i*diff / anz).strftime("%b-%d\n%H:%M")
        else
          text = ""
        end
        OFC::XAxisLabel.new #("abla") #, '#0000ff', 10, 'diagonal')
      end.compact

      x_achse = OFC::XAxis.new
      x_achse.set_labels x_labels
      x_achse.set_range(0, anz, 10)

      @chart.x_axis = x_achse
      #chart.x_label_style(10, '#9933CC',2,2)
      #chart.set_x_label_style(10, '#9933CC',2,2)    
  end

  def linien_hinzu(diaquen, streck_fkt)
    diaquen.each do |diaque|
        kurve = Kurve.new(diaque, akt_zeit)
        
        line = OFC::Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
        line.text = diaque.quelle.name
        line.width = 3
        line.colour = diaque.farbe || diaque.quelle.farbe
        line.dot_size = 5
        aufgefuellte_linien_daten = kurve.linien_daten.inject([]) do |neue_liste, wert|
          neue_liste << (wert || neue_liste.last)
        end
        line.values = aufgefuellte_linien_daten.map{|z| p [z, (streck_fkt &&  streck_fkt[z])]; (streck_fkt ? streck_fkt[z] : z) }
        # Funktioniert nicht:
        # chart.tool_tip = ('#x_label# [#val#]<br>#tip#')
        @chart.elements << line
      end
  end

  def chart_kurven
    #self.extend OFC
    @diagramm = Diagramm.find(params[:id])
    @chart = OFC::OpenFlashChart.new( @diagramm.name )
    @chart.elements = []
    @streckungs_funktion = nil
    #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
    #chart.set_title(@diagramm.name)

    setze_skalen(@chart)
    
    streck_fkt = nil
    emd = @diagramm.einheiten_mit_diaquen
    
    @diagramm.einheiten.map{|e| emd[e]}.each do |diaquen|
      linien_hinzu(diaquen, streck_fkt)
      streck_fkt = @streckungs_funktion
    end

    setze_xlabels #(kurve)
  end


  # GET /diagramme/1
  # GET /diagramme/1.xml
  def show
    akt_zeit
    chart = chart_kurven
    init_diaquenauswahl
   # macht folgende Zeile überflüssig
    #@diagramm = Diagramm.find(params[:id])
    @titelzeile = @diagramm.name + " - KabDiag"
    respond_to do |format|
      format.html {
      }
      format.skala {
        render :text => skala_chart, :layout => false
      }
      format.json {
        render :text => chart, :layout => false
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

    init_diaquenauswahl_fuer_view
    render :partial => "quellen_auswahl_listen", :layout => false
  end

  def quelle_raus
    @diagramm = Diagramm.find(params[:id])
    quelle = Quelle.find params[:quelle_id].to_i

    @diagramm.quellen.delete quelle
    @diagramm.save!

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
