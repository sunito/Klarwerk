class DiagrammeController < ApplicationController
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
    y_legende.set_style("{font-size: 20px; color: #{einheit.farbe}}")

    y_achse = YAxis.new
    abstand = (einheit.max - einheit.min) / 15.0
    grob = 10   **   ((abstand/1.6).to_i.to_s.size - 1)
    abstand = round(abstand / grob) * grob
    y_achse.set_range(einheit.min, einheit.max, abstand)

    chart.set_y_legend(y_legende)
    chart.y_axis = y

  end

  def chart_kurven
    OpenFlashChart.new( "MY TITLE" ) do |chart|
      #chart << BarGlass.new( :values => (1..10).sort_by{rand} )
      chart.set_title(@diagramm.name)

      kurven = {}
      @diagramm.diaquen.each do |diaque|
        kurve = Kurve.new(diaque, aktuelle_zeit)
        line = Line.new
        line.text = diaque.quelle.name
        line.width = 1
        line.colour = diaque.farbe
        line.dot_size = 5
        line.values = kurve.linien_daten.map{|z| z * diaque.streckungsfaktor}
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
