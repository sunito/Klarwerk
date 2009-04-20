class DiagrammeController < ApplicationController

  def akt_zeit
    #session[:zeit] ||=
    Zeit.die_aktuelle
  end

  # GET /diagramme
  # GET /diagramme.xml
  def index
    @diagramme = Diagramm.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diagramme }
    end
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

  def setze_y_einheit(chart, einheit)
    y_legende = YLegend.new(einheit.name)
    y_legende.set_style("{font-size: 20px; color: #778877}")

    y_achse = YAxis.new
    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.set_range(einheit.min, einheit.max, abstand)

    #chart.set_y_legend(y_legende)
    chart.y_axis = y_achse

    y_legende = YLegendRight.new(einheit.name)
    #y_legende.set_style("{font-size: 20px; color: #778877}")
    y_legende.style_right = '{font-size: 70px; color: #778877}'

    chart.y_legend_right = y_legende

    y_achse = YAxisRight.new
    abstand = (einheit.max - einheit.min) / 20.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = (abstand / grob).round * grob
    y_achse.range_right = [einheit.min, einheit.max, abstand]
    p abstand

    chart.y_axis_right = y_achse

  end

  def chart_kurven
    @diagramm = Diagramm.find(params[:id])
   title = Title.new("Multiple Lines")

    data1 = []
    data2 = []
    data3 = []

    10.times do |x|
    data1 << rand(5) + 1
    data2 << rand(6) + 7
    data3 << rand(5) + 14
    end

    line_dot = LineDot.new
    line_dot.width = 4
    line_dot.colour = '#DFC329'
    line_dot.dot_size = 5
    line_dot.values = data1

    line_hollow = LineHollow.new
    line_hollow.width = 1
    line_hollow.colour = '#6363AC'
    line_hollow.dot_size = 5
    line_hollow.values = data2

    line = Line.new
    line.width = 1
    line.colour = '#5E4725'
    line.dot_size = 5
    line.values = data3

    # Added these lines since the previous tutorial
    tmp = []
    x_labels = XAxisLabels.new
    x_labels.set_vertical()

    %w(one two three four five six seven eight nine ten).each do |text|
      tmp << XAxisLabel.new(text, '#0000ff', 20) #, 'diagonal')
      #tmp << XAxisLabel.new(text, '#0000ff', 20, 'horizontal')
      #tmp << XAxisLabel.new(text, '#0000ff', 20, )
    end

    x_labels.labels = tmp
    x_labels.rotate= 'diagonal'
    x = XAxis.new
    x.set_labels(x_labels)
    # new up to here ...

    y = YAxis.new
    y.set_range(0,20,5)

    x_legend = XLegend.new("MY X Legend")
    x_legend.set_style('{font-size: 20px; color: #778877}')

    y_legend = YLegend.new("MY Y Legend")
    y_legend.set_style('{font-size: 20px; color: #770077}')

    chart =OpenFlashChart.new
    chart.set_title(title)
    chart.set_x_legend(x_legend)
    chart.set_y_legend(y_legend)
    chart.x_axis = x # Added this line since the previous tutorial
    chart.y_axis = y

    chart.add_element(line_dot)
    chart.add_element(line_hollow)
    chart.add_element(line)

    #render :text => chart.to_s
    @chart = chart
  end
  def xx_chart_kurven
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
            text = (kurve.von + i*diff / anz).strftime("%H:%M")
            XAxisLabel.new(text, '#0000ff', 20, 'diagonal')
          end

          x_achse = XAxis.new
          x_achse.set_labels x_labels

          chart.x_axis = x_achse
          #chart.x_label_style(10, '#9933CC',2,2)
          #chart.set_x_label_style(10, '#9933CC',2,2)
        end
        line = Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
        line.text = diaque.quelle.name
        line.width = 3
        line.colour = diaque.farbe || diaque.quelle.farbe
        line.dot_size = 5
        line.values = kurve.linien_daten.map{|z| z and z * (diaque.streckungsfaktor||1) }
        chart.add_element(line)
      end



      setze_y_einheit(chart, @diagramm.haupt_einheit)

      #x_legend = XLegend.new("MY X Legend")
      #x_legend.set_style('{font-size: 20px; color: #778877}')
      #chart.set_x_legend(x_legend)

   

    end
  end


  # GET /diagramme/1
  # GET /diagramme/1.xml
  def show
    #@diagramm = Diagramm.find(params[:id])

    respond_to do |format|
      format.html {
        #erstelle_graph
        chart_kurven
      }
      format.skala {
        render :text => skala_chart, :layout => false
      }
      format.json {
        chart = chart_kurven
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
    @freie_quellen = Quelle.all - @diagramm.quellen 
    @ausgewaehlte_diaquen = @diagramm.diaquen  
  end

  def quelle_rein
    @diagramm = Diagramm.find(params[:id])
    quelle = Quelle.find params[:quelle_id].to_i

    @diagramm.quellen << quelle
    @diagramm.save!

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
