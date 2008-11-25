class QuellenController < ApplicationController
  # GET /quellen
  # GET /quellen.xml
  def index
    @quellen = Quelle.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quellen }
    end
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
        format.html { redirect_to(@quelle) }
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
        format.html { redirect_to(@quelle) }
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
end
