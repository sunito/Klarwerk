class DiagrammeController < ApplicationController
  OFC = self
  
  def akt_zeit

    session[:akt_zeit] ||= Zeit.die_aktuelle
  end

  # GET /diagramme
  # GET /diagramme.xml
  def index
    session[:akt_zeit] = Zeit::STANDARDZEIT
    session[:akt_zeit].bis = Time.at((Messpunkt.find(1).sekzeit)+3600*12)
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

  private
  def render_zeit_update
    ##chart_kurven
    highchart_kurven
    #render :action => "update_zeit.rjs", :layout => false
    render :action => "grafik_aktualisierer.js.erb", :layout => false
  end

  public
  #def links
    #akt_zeit.zurueck!
    #render_zeit_update

    #    chart_kurven
    #    respond_to do |format|
    #      format.html {
    #        render :inline => open_flash_chart_object("100%",700, url_for(:format => "json"))
    #      }
    #      format.json {
    #        render :inline => @chart
    #      }
    #    end
  #end

  #def rechts
    #akt_zeit.weiter!
    #chart_kurven
    #render :inline => @chart
    #render_zeit_update
  #end
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
    render_zeit_update
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
    #render_zeit_update
  #end

  def dauer
    akt_zeit.dauer = params[:dauer]
    #render :inline => @chart
    p [:dauer, params[:dauer]]
    #render :template => "update_zeit"
    render_zeit_update
  end

  def zoom_out
    akt_zeit.laenger!
    #render :inline => @chart
    p :zoomout
    #render :template => "update_zeit"
    render_zeit_update
  end

  def zoom_in
    akt_zeit.kuerzer!
    render_zeit_update
  end

  def skala_chart
    p :skala
    return "skala_chart ist nicht implementiert"

    
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
    y_legende = OFC::YLegend.new
    y_legende.text = einheit.name
    #y_legende.style = ("{font-size: 20px; color: #{emq[einheit].first.farbe}}")

    y_achse = OFC::YAxis.new
    #chart.y_legend = (y_legende)

    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.min = einheit.min
    y_achse.max = einheit.max
    y_achse.steps = einheit.schritt_fuer_anzahl(20)
    chart.y_axis = y_achse

    warn ["EZZZZZZZZZZZZZZZZZZZ444ZZZZZZZZZZZZZZZZZ", @diagramm.zweite_skala?]
    if @diagramm.zweite_skala? then
      zweite_einheit = @diagramm.einheiten[1]
      @streckungs_funktion = proc do |orig_wert|
        orig_wert && (einheit.min + (orig_wert - zweite_einheit.min) * einheit.hub / zweite_einheit.hub)
      end
      warn ["EZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ", einheit.hub, zweite_einheit.hub]
      warn @streckungs_funktion[100]
      
      #      y_legende = YLegendRight.new(einheit.name)
      #      #y_legende.set_style("{font-size: 20px; color: #778877}")
      #      #y_legende.style = '{font-size: 70px; color: #778877}'
      #      y_legende.set_style("{font-size: 20px; color: #{emq[zweite_einheit].first.farbe}}")
      #      chart.set_y_legend_right  y_legende
      #      #chart.set_y_legend_right( 'Free Ram (MB)' ,40 , '#164166' )


      y_achse = YAxisRight.new
      #y_achse = YAxis.new
      #y_achse.set_range(einheit.min, einheit.max, einheit.schritt_fuer_anzahl(20))
      # Workaraund
      g = zweite_einheit.groeszenordnung
      y_achse.min = zweite_einheit.min #/ g
      y_achse.max = zweite_einheit.max #/ g

      schritt_weite = zweite_einheit.schritt_fuer_anzahl(20)
      #y_achse.steps = 20 #zweite_einheit.schritt_fuer_anzahl(20)
      y_achse.labels = (zweite_einheit.min.to_i..zweite_einheit.max.to_i).to_a.map {|i| i % schritt_weite == 0 ? i : nil}.compact
      #p [:abstand, abstand]
      chart.y_axis_right = y_achse

    end
  end

  def setze_xlabels(label_steps = 10) 
    #x_achse.set_range(kurve.von, kurve.bis, 60)

    
    #      x_labels = OFC::XAxisLabels.new
    #      #x_labels.style
    #      x_labels.set_vertical()
    #      x_labels.steps = label_steps
    #      x_labels.rotate = 270

    diff = akt_zeit.dauer
    require 'kurve'
    anz = GLOBAL_X_ANZAHL

    
    x_labelslabels = (0..anz).map do |i|
      if i % label_steps == 0
        text = (akt_zeit.vonzeit + i*diff / anz).strftime("%b-%d\n%H:%M")
      else
        text = ""
      end
      #OFC::XAxisLabel.new #("abla") #, '#0000ff', 10, 'diagonal')
      text
    end.compact

    format = case diff
    when (0 .. 18.hours)
      "%H:%M"
    when (18.hours .. 4.weeks)
      "%b-%d\n %H:%M"
    else
      "%b-%d, %H--"
    end
    x_label_texte = (0..anz).map do |i|
      if i % label_steps == 0
        (akt_zeit.vonzeit + i*diff / anz).strftime(format)
      else
        ""
      end
    end

    x_labels = OFC::XAxisLabels.new
    #x_labels.set_vertical()
    x_labels.steps = label_steps
    x_labels.rotate = 315
    x_labels.labels = x_label_texte
    #x_labels.labels = x_labelslabels #x_label_texte

    x_achse = OFC::XAxis.new
    x_achse.labels = x_labels
    x_achse.steps = label_steps
    #x_achse.set_range(0, anz, 10)

    @chart.x_axis = x_achse
    #chart.x_label_style(10, '#9933CC',2,2)
    #chart.set_x_label_style(10, '#9933CC',2,2)
    x_label_texte
  end

  def linien_hinzu(diaquen, streck_fkt_param)
    diaquen.each_with_index do |diaque, idx|

      kurve = Kurve.new(diaque, akt_zeit)

      line = OFC::Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
      line.text = diaque.quelle.name
      line.font_size = 20
      line.width = 3
      line.colour = diaque.anzuzeigende_farbe
      line.dot_size = 5
      aufgefuellte_linien_daten = kurve.linien_daten.inject([]) do |neue_liste, wert|
        neue_liste << (wert || neue_liste.last)
      end

      dual_streck_fkt = if diaque.quelle.einheit.name =~ /aus.*ein/i
        einheit = @diagramm.haupt_einheit
        max = einheit.max
        min = einheit.min
        binaer_anzahl = 10
        #binaer_hoehe = 1.0 / binaer_anzahl/ 2
        proc {|z| z && min + (max-min) * (binaer_anzahl - idx - 0.7 + (z>0 ? 0.5 : 0)  )  / binaer_anzahl } 
      end
      streck_fkt = dual_streck_fkt || if streck_fkt_param
        if dual_streck_fkt
          sf = dual_streck_fkt
          #proc {|z| streck_fkt_param[sf[z]]}
        else
          line.attach_to_right_y_axis
          streck_fkt_param
          nil
        end       
      end
      line.values = aufgefuellte_linien_daten.map do |z|
        #p ["z, z-streck", z, (streck_fkt &&  streck_fkt[z])];
        (streck_fkt ? streck_fkt[z] : z)
      end
      #@chart.attach_to_y_right_axis(line.id)
      #line.attach
      # Funktioniert nicht:
      # chart.tool_tip = ('#x_label# [#val#]<br>#tip#')
      #@chart.set_tooltip("NULL", 2) #"["abs"]*30"NULL""
      @chart.add_element line
    end
  end

  def xx_chart_kurven
    #self.extend OFC
    @diagramm = Diagramm.find(params[:id])
    #@chart = OFC::OpenFlashChart.new
    @chart = OpenFlashChart.new
    @chart.title = {:text => @diagramm.name , :style => "{font-size: 30px;}"}
    @chart.elements = []
    @streckungs_funktion = nil
    #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
    #chart.set_title(@diagramm.name)

    setze_skalen(@chart)
    
    streck_fkt = nil
    emd = @diagramm.einheiten_mit_diaquen
    
    @diagramm.einheiten.map{|e| emd[e]}.each do |diaquen|      
      linien_hinzu(diaquen, streck_fkt)
      line = OFC::Line.new
      line.text = "      "
      line.colour = "ffffff"
      @chart.add_element line
      streck_fkt = @streckungs_funktion
    end

    setze_xlabels #(kurve)
  end

  def highchart_kurven
    #self.extend OFC
    @diagramm = Diagramm.find(params[:id])
    emd = @diagramm.einheiten_mit_diaquen
    #@chart = OFC::OpenFlashChart.new

    @highchart = LazyHighCharts::HighChart.new('graph') do |hc|
      hc.title :text => @diagramm.name #, :style => "{font-size: 30px;}"}

      y_achsen = []
      @diagramm.einheiten.each do |einheit|
        point_start = nil
        emd[einheit].each_with_index do |diaquen, dia_idx|
          diaquen = [diaquen] unless diaquen.respond_to? :each
          diaquen.each_with_index do |diaque, idx|
            kurve = Kurve.new(diaque, akt_zeit)
            point_start ||= kurve.von.to_i*1000
            aufgefuellte_linien_daten = kurve.linien_daten.inject([]) do |neue_liste, wert|
              neue_liste << (wert || neue_liste.last)
            end
            hc.series ({     
              type: 'line'   , 
              name: diaque.quelle.name, 
              color: "#" + diaque.anzuzeigende_farbe,
              point_start: point_start, 
              point_interval: kurve.x_schritt * 1000, 
              y_axis: y_achsen.size,
              data: aufgefuellte_linien_daten
            })
          end
        end
        y_achsen << {
          labels: {format: "{value} #{einheit.name}"}, 
          min: einheit.min, 
          max: einheit.max, 
          title: {text: einheit.beschreibung}, 
          opposite: (y_achsen.size > 0)
        }

      end
      hc.x_axis type: 'datetime'
      #hc.x_axis :categories => setze_xlabels(17) + ["e"] #, :labels => {:rotation => 315}
      hc.y_axis y_achsen
#      f.title({:text => "Werte vom #{tag}"}) #Problem: Wenn mehr als ein Tag angezeigt wird, wird als Titel nur Datum eines Tages angezeigt 
    end      
    @streckungs_funktion = nil
    #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
    #chart.set_title(@diagramm.name)

#    setze_skalen(@chart)
=begin    
    streck_fkt = nil
    emd = @diagramm.einheiten_mit_diaquen
    
    @diagramm.einheiten.map{|e| emd[e]}.each do |diaquen|      
      linien_hinzu(diaquen, streck_fkt)
      line = OFC::Line.new
      line.text = "      "
      line.colour = "ffffff"
      @chart.add_element line
      streck_fkt = @streckungs_funktion
    end
=end
     #(kurve)
  end

  # nur eine Test-Action für Chartkick. Funktioniert, aber Chartkick ist einfach zu unflexibel
  def ajja
    @diagramm = Diagramm.find(params[:id])
    p "params[:id]"
    p params[:id]
    p @diagramm
    emd = @diagramm.einheiten_mit_diaquen
    #@chart = OFC::OpenFlashChart.new

    
      #hc.title :text => @diagramm.name #, :style => "{font-size: 30px;}"}

      alle_linien = nil
      y_achsen_zaehler = 0
      y_achsen = []
      alle_linien = @diagramm.einheiten.map do |einheit|
        y_achsen << {labels: {format: "{value} #{einheit.name}"}, title: {text: einheit.beschreibung}, opposite: (y_achsen_zaehler > 1)}
        emd[einheit].map do |diaquen|
          diaquen = [diaquen] unless diaquen.respond_to? :each
            diaquen.map do |diaque|
            aufgefuellte_linien_daten = {}
            #kurve = Kurve.new(diaque, Zeit.finde_oder_neu(Time.new(2015,3,1, 11, 0), 3600*34))
            kurve = Kurve.new(diaque, akt_zeit)
            l_daten = kurve.linien_daten
            p l_daten
            letzter_wert = 0
            l_daten.each_with_index do |wert, i|
              z = kurve.von + ((kurve.bis - kurve.von) * i) / l_daten.size
              aufgefuellte_linien_daten[z.to_s] ||= letzter_wert = (wert || letzter_wert) 
            end
#            hc.series type: 'line', name: diaque.quelle.name, point_start: kurve.von.to_i*1000, data: aufgefuellte_linien_daten
 #           hc.y_axis y_achsen_zaehler
            y_achsen_zaehler += 1
            { name: diaque.quelle.name, data: aufgefuellte_linien_daten }
          end
        end
      end.flatten
  #    hc.x_axis type: 'datetime'
      #hc.x_axis :categories => setze_xlabels(17) + ["e"] #, :labels => {:rotation => 315}
   #   hc.y_axis y_achsen
#      f.title({:text => "Werte vom #{tag}"}) #Problem: Wenn mehr als ein Tag angezeigt wird, wird als Titel nur Datum eines Tages angezeigt 
    #end      
    p :alle_linien
    p alle_linien
    render :json => alle_linien
      #{"2013-02-10"=> 11, "2013-02-11"=> 6, "2013-02-12"=> 12, "2013-02-13"=> 5}#, 
#                     library:
 #                       {title:   "Company Performance",
  #                       x_axis:   {title: "Date", gridlines: {count:3,color:"#CCC"}, format:"dd/MM/yy"}}, 
   #                  discrete: true
    #                ]#.to_json
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
      format.skala {
        render :text => skala_chart, :layout => false
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
