class EinheitenController < ApplicationController
  # GET /einheiten
  # GET /einheiten.xml
  def index
    @einheiten = Einheit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @einheiten }
    end
  end

  # GET /einheiten/1
  # GET /einheiten/1.xml
  def show
    @einheit = Einheit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @einheit }
    end
  end

  # GET /einheiten/new
  # GET /einheiten/new.xml
  def new
    @einheit = Einheit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @einheit }
    end
  end

  # GET /einheiten/1/edit
  def edit
    @einheit = Einheit.find(params[:id])
  end

  # POST /einheiten
  # POST /einheiten.xml
  def create
    @einheit = Einheit.new(params[:einheit])

    respond_to do |format|
      if @einheit.save
        flash[:notice] = 'Einheit wurde gespeichert.'
        format.html { redirect_to(@einheit) }
        format.xml  { render :xml => @einheit, :status => :created, :location => @einheit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @einheit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /einheiten/1
  # PUT /einheiten/1.xml
  def update
    @einheit = Einheit.find(params[:id])

    respond_to do |format|
      if @einheit.update_attributes(params[:einheit])
        flash[:notice] = 'Einheit wurde gespeichert.'
        format.html { redirect_to(@einheit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @einheit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /einheiten/1
  # DELETE /einheiten/1.xml
  def destroy
    @einheit = Einheit.find(params[:id])
    @einheit.destroy

    respond_to do |format|
      format.html { redirect_to(einheiten_url) }
      format.xml  { head :ok }
    end
  end
end
