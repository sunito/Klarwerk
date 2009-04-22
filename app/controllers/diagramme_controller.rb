class DiagrammeController < ApplicationController

  def akt_zeit
    #session[:zeit] ||=
    Zeit.die_aktuelle
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
    render :inline => @chart
  end

  def rechts
    akt_zeit.weiter!
    chart_kurven
    render :inline => @chart
  end

  def zoom_out
    akt_zeit.laenger!
    chart_kurven
    respond_to do |format|
      format.html {
        if request.xhr? then
          #render :inline => @chart.js_open_flash_chart_object("my_chart_js_1", "100%", 500)
        else
          redirect_to :action => "show"
        end
      }
      format.json {
        render :inline => @chart
      }
    end
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
    emq = @diagramm.einheiten_mit_quellen

    einheit = @diagramm.haupt_einheit

    y_legende = YLegend.new(einheit.name)
    y_legende.set_style("{font-size: 20px; color: #{emq[einheit].first.farbe}}")
    chart.y_legend = (y_legende)

    y_achse = YAxis.new
    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
    chart.y_axis = y_achse

    if @diagramm.zweite_skala? then
      einheit = @diagramm.einheiten[1]
      y_legende = YLegendRight.new(einheit.name)
      #y_legende.set_style("{font-size: 20px; color: #778877}")
      y_legende.style = '{font-size: 70px; color: #778877}'
      y_legende.set_style("{font-size: 20px; color: #{emq[einheit].first.farbe}}")
      chart.y_legend_right = y_legende

      y_achse = YAxisRight.new
      #y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
      # Workaraund
      g = einheit.groeszenordnung
      y_achse.set_range(einheit.min / g, einheit.max / g)
      #p [:abstand, abstand]
      chart.y_axis_right = y_achse
    end
  end

  def chart_kurven
    @diagramm = Diagramm.find(params[:id])
    @chart = OpenFlashChart.new( @diagramm.name ) do |chart|
      #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
      #chart.set_title(@diagramm.name)

      erstes_mal = true
      @diagramm.diaquen.each do |diaque|
        kurve = Kurve.new(diaque, akt_zeit)
        if erstes_mal then
          erstes_mal = false
          #x_achse.set_range(kurve.von, kurve.bis, 60)

          x_labels = XAxisLabels.new
          #x_labels.style
          x_labels.set_vertical()

          diff = kurve.bis - kurve.von
          anz = GLOBAL_X_ANZAHL 
          x_labels.labels = (0..anz).map do |i|
            if i % 10 == 0
              text = (kurve.von + i*diff / anz).strftime("%b-%d\n%H:%M")
            else
              text = ""
            end
            XAxisLabel.new(text, '#0000ff', 10, 'diagonal') 
          end.compact

          x_achse = XAxis.new
          x_achse.set_labels x_labels
          x_achse.set_range(0, anz, 10)

          chart.x_axis = x_achse
          #chart.x_label_style(10, '#9933CC',2,2)
          #chart.set_x_label_style(10, '#9933CC',2,2)
        end
        line = Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
        line.text = diaque.quelle.name
        line.width = 3
        line.colour = diaque.farbe || diaque.quelle.farbe
        line.dot_size = 5
        aufgefuellte_linien_daten = kurve.linien_daten.inject([]) do |neue_liste, wert|
          neue_liste << (wert || neue_liste.last)
        end
        line.values = aufgefuellte_linien_daten.map{|z| z and z * (diaque.streckungsfaktor||1) }
        # Funktioniert nicht:
        # chart.tool_tip = ('#x_label# [#val#]<br>#tip#')
        chart.add_element(line)
      end

      setze_skalen(chart)
    end
  end


  # GET /diagramme/1
  # GET /diagramme/1.xml
  def show
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
        format.html { redirect_to(@diagramm) }
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
