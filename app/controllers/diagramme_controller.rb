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

  # GET /diagramme/1
  # GET /diagramme/1.xml
  def show
    @diagramm = Diagramm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diagramm }
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
