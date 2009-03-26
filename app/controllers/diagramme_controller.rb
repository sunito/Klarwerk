class DiagrammeController < ApplicationController

  def akt_zeit
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

  def erstelle_graph
    hoehe = 600
    @graph = open_flash_chart_object( "80%", hoehe, url_for( :action => 'show', :format => :json ) )
    if @diagramm.zweite_skala? then
      @zusatz_skala = open_flash_chart_object( 55, hoehe, url_for( :action => 'show', :format => :skala ) )
    end

  end

  def rechts
    akt_zeit.zurueck!
    #erstelle_graph
    chart_kurven
    #@graph = "<hr><hr>"
    render :template => "diagramme/grafik_aktualisierer.rjs", :layout => false
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
    @chart = OpenFlashChart.new( @diagramm.name ) do |chart|
      #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
      #chart.set_title(@diagramm.name)

      erstes_mal = true
      @diagramm.diaquen.each do |diaque|
        kurve = Kurve.new(diaque, akt_zeit)
        if erstes_mal then
          erstes_mal = false
          x_achse = XAxis.new
          #x_achse.set_range(kurve.von, kurve.bis, 60)

          x_labels = XAxisLabels.new
          x_labels.set_vertical()

          diff = kurve.von - kurve.bis
          anz = GLOBAL_X_ANZAHL
          x_labels.labels = (0..anz).map do |i|
            text = (kurve.von + i*diff / anz).strftime("%H:%M")
            XAxisLabel.new(text, '#0000ff', 10, 'diagonal')
          end
          x_achse.set_labels(x_labels)

          chart.x_axis = x_achse
        end
        line = Line.new   #([:a,:b,:c])#(2) #, "#FF0000")
        line.text = diaque.quelle.name
        line.width = 3
        line.colour = "#111111" #diaque.farbe
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
    @diagramm = Diagramm.find(params[:id])

    respond_to do |format|
      format.html {
        erstelle_graph
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diagramm }
    end
  end

  # GET /diagramme/1/edit
  def edit
    @diagramm = Diagramm.find(params[:id])
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

    respond_to do |format|
      p [:XXXXXXXXXXXX, 'params[:diagramm]', params[:diagramm]]
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
end
