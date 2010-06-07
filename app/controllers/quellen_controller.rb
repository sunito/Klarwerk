class QuellenController < ApplicationController
  # GET /quellen
  # GET /quellen.xml
  def index
    @alle_quellen = Quelle.all
    @aktive_quellen = Quelle.alle_aktiven
    @inaktive_quellen = @alle_quellen - @aktive_quellen

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quellen }
    end
  end

  def aktiv_umschalten
    @quelle = Quelle.find(params[:id])
    @quelle.aktiv = ! @quelle.aktiv
    @quelle.save!
    redirect_to :action => 'index'
  end

  # GET /quellen/1
  # GET /quellen/1.xml
  def show
    @quelle = Quelle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quelle }
    end
  end

  # GET /quellen/new
  # GET /quellen/new.xml
  def new
    @quelle = Quelle.new
    @quelle.aktiv = true

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quelle }
    end
  end

  # GET /quellen/1/edit
  def edit
    @quelle = Quelle.find(params[:id])
  end

  # POST /quellen
  # POST /quellen.xml
  def create
    @quelle = Quelle.new(params[:quelle])

    respond_to do |format|
      if @quelle.save
        flash[:notice] = 'Messgr&ouml;&szlig;e wurde gespeichert.'
        format.html { redirect_to(quellen_path) }
        format.xml  { render :xml => @quelle, :status => :created, :location => @quelle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quellen/1
  # PUT /quellen/1.xml
  def update
    @quelle = Quelle.find(params[:id])

    respond_to do |format|
      if @quelle.update_attributes(params[:quelle])
        flash[:notice] = 'Messgr&ouml;&szlig;e wurde gespeichert'
        format.html { redirect_to(quellen_path) } #@quelle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quelle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quellen/1
  # DELETE /quellen/1.xml
  def destroy
    @quelle = Quelle.find(params[:id])
    @quelle.destroy

    respond_to do |format|
      format.html { redirect_to(quellen_url) }
      format.xml  { head :ok }
    end
  end


  def generiere
    @quelle = Quelle.find(params[:id])
    zeitraum = Zeit.new
    zeitraum.dauer = params[:tage].to_i.days
    if zeitraum.dauer == 0
      return redirect_to :action => "index"
    end
    zeitraum.bis = Time.now - params[:tage_zurueck].to_i.days if params[:tage_zurueck]
    @quelle.generiere_zufaellig(zeitraum)
    redirect_to :controller => "messpunkte", :action => "index"
  end

end
