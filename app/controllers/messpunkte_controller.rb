class MesspunkteController < ApplicationController
  # GET /messpunkte
  # GET /messpunkte.xml
  def index
    @messpunkte = Messpunkt.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messpunkte }
    end
  end

  # GET /messpunkte/1
  # GET /messpunkte/1.xml
  def show
    @messpunkt = Messpunkt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @messpunkt }
    end
  end

  # GET /messpunkte/new
  # GET /messpunkte/new.xml
  def new
    @messpunkt = Messpunkt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @messpunkt }
    end
  end

  # GET /messpunkte/1/edit
  def edit
    @messpunkt = Messpunkt.find(params[:id])
  end

  # POST /messpunkte
  # POST /messpunkte.xml
  def create
    @messpunkt = Messpunkt.new(params[:messpunkt])

    respond_to do |format|
      if @messpunkt.save
        flash[:notice] = 'Messpunkt was successfully created.'
        format.html { redirect_to(@messpunkt) }
        format.xml  { render :xml => @messpunkt, :status => :created, :location => @messpunkt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @messpunkt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messpunkte/1
  # PUT /messpunkte/1.xml
  def update
    @messpunkt = Messpunkt.find(params[:id])

    respond_to do |format|
      if @messpunkt.update_attributes(params[:messpunkt])
        flash[:notice] = 'Messpunkt was successfully updated.'
        format.html { redirect_to(@messpunkt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @messpunkt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messpunkte/1
  # DELETE /messpunkte/1.xml
  def destroy
    @messpunkt = Messpunkt.find(params[:id])
    @messpunkt.destroy

    respond_to do |format|
      format.html { redirect_to(messpunkte_url) }
      format.xml  { head :ok }
    end
  end
end
