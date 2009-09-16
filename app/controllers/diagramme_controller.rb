class DiagrammeController < ApplicationController

  def akt_zeit
    session[:akt_zeit] ||= Zeit.die_aktuelle
    @akt_zeit = session[:akt_zeit]
  end

  # GET /diagramme
  # GET /diagramme.xml
  def index
    @diagramme = Diagramm.find(:all)
  end

  def render_zeit_update
    chart_generieren
    render :action => "update_zeit.rjs", :layout => false
  end
  private :render_zeit_update
  
  def links
    akt_zeit.zurueck!
    render_zeit_update
  end

  def rechts
    akt_zeit.weiter!
    render_zeit_update
  end

  def dauer
    akt_zeit.dauer = params[:dauer]
    render_zeit_update
  end

  def zoom_out
    akt_zeit.laenger!
    render_zeit_update
  end

  def zoom_in
    akt_zeit.kuerzer!
    render_zeit_update
  end


  # GET /diagramme/1
  # GET /diagramme/1.json
  def show
    akt_zeit
    chart_generieren
   # macht folgende Zeile überflüssig
    #@diagramm = Diagramm.find(params[:id])
    init_diaquenauswahl
    @titelzeile = @diagramm.name + " - KabDiag"
    respond_to do |format|
      format.html {
      }
      format.json {
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

  def init_diaquenauswahl
    init_diaquenauswahl_fuer_view
  end

  # POST /diagramme
  def create
    @diagramm = Diagramm.new(params[:diagramm])

    respond_to do |format|
      if @diagramm.save
        flash[:notice] = 'Diagramm wurde erstellt.'
        format.html { redirect_to(edit_diagramm_path(@diagramm)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /diagramme/1
  def update
    @diagramm = Diagramm.find(params[:id])
    respond_to do |format|
      if @diagramm.update_attributes(params[:diagramm])
        flash[:notice] = 'Diagramm wurde gespeichert.'
        format.html { redirect_to(@diagramm) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /diagramme/1
  def destroy
    @diagramm = Diagramm.find(params[:id])
    @diagramm.destroy

    respond_to do |format|
      format.html { redirect_to(diagramme_url) }
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

private
  
  def chart_generieren
    @diagramm = Diagramm.find(params[:id])
    @chart = OFC::OpenFlashChart.new
    @chart.title = {:text => @diagramm.name , :style => "{font-size: 30px;}"}
    @chart.elements = []
    @streckungs_funktion = nil

    setze_skalen
    
    streck_fkt = nil
    emd = @diagramm.einheiten_mit_diaquen
    
    @diagramm.einheiten.map{|e| emd[e]}.each do |diaquen|
      linien_hinzu(diaquen, streck_fkt)
      line = OFC::Line.new
      line.text = "      "
      line.colour = "ffffff"
      @chart.elements << line
      streck_fkt = @streckungs_funktion
    end

    setze_xlabels 
  end

  def setze_skalen
    emq = @diagramm.einheiten_mit_diaquen

    einheit = @diagramm.haupt_einheit
    return if not einheit

    y_legende = OFC::YLegend.new
    y_legende.text = einheit.name

    y_achse = OFC::YAxis.new

    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.min = einheit.min
    y_achse.max = einheit.max
    y_achse.steps = einheit.schritt_fuer_anzahl(20)
    @chart.y_axis = y_achse

    if @diagramm.zweite_skala? then
      zweite_einheit = @diagramm.einheiten[1]
      @streckungs_funktion = proc do |orig_wert|
        orig_wert && (einheit.min + (orig_wert - zweite_einheit.min) * einheit.hub / zweite_einheit.hub)
      end

  #      y_achse = YAxisRight.new
      y_achse = YAxis.new
      #y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
      # Workaraund wegen OFC-Problem
      g = zweite_einheit.groeszenordnung
      y_achse.min = zweite_einheit.min #/ g
      y_achse.max = zweite_einheit.max #/ g

      schritt_weite = zweite_einheit.schritt_fuer_anzahl(20)
      y_achse.labels = (y_achse.min.to_i..y_achse.max.to_i).to_a.map {|i| i % schritt_weite == 0 ? i : nil}.compact
      @chart.y_axis_right = y_achse
    end
  end

  def setze_xlabels
    label_steps = 10
    diff = akt_zeit.dauer
    anz = Kurve::GLOBAL_X_ANZAHL

    format = case diff
    when (0 .. 18.hours)
      "%H:%M"
    when (18.hours .. 4.weeks)
      "%b-%d\n %H:%M"
    else
      "%b-%d, %H°°"
    end
    x_label_texte = (0..anz).map do |i|
      (akt_zeit.vonzeit + i*diff / anz).strftime(format)
    end

    x_labels = OFC::XAxisLabels.new
    x_labels.steps = label_steps
    x_labels.rotate = 315
    x_labels.labels = x_label_texte

    x_achse = OFC::XAxis.new
    x_achse.labels = x_labels
    x_achse.steps = label_steps
    #x_achse.set_range(0, anz, 10)

    @chart.x_axis = x_achse
  end

  def linien_hinzu(diaquen, streck_fkt)
    diaquen.each do |diaque|
        kurve = Kurve.new(diaque, akt_zeit)

        line = OFC::Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
        line.text = diaque.quelle.name
        line.font_size = 20
        line.width = 3
        line.colour = diaque.farbe || diaque.quelle.farbe
        line.dot_size = 5
        aufgefuellte_linien_daten = kurve.linien_daten.inject([]) do |neue_liste, wert|
          neue_liste << (wert || neue_liste.last)
        end
        line.values = aufgefuellte_linien_daten.map{|z| p [z, (streck_fkt &&  streck_fkt[z])]; (streck_fkt ? streck_fkt[z] : z) }
        # Funktioniert nicht:
        # chart.tool_tip = ('#x_label# [#val#]<br>#tip#')
        #@chart.set_tooltip("NULL", 2) #"["abs"]*30"NULL""
        @chart.elements << line
      end
  end

end
