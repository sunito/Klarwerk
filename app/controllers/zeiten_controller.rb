class ZeitenController < ApplicationController
  # GET /zeiten
  # GET /zeiten.xml
  def index
    @zeiten = Zeit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zeiten }
    end
  end

  # GET /zeiten/1
  # GET /zeiten/1.xml
  def show
    @zeit = Zeit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zeit }
    end
  end

  # GET /zeiten/new
  # GET /zeiten/new.xml
  def new
    @zeit = Zeit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zeit }
    end
  end

  # GET /zeiten/1/edit
  def edit
    @zeit = Zeit.find(params[:id])
  end

  # POST /zeiten
  # POST /zeiten.xml
  def create
    @zeit = Zeit.new(params[:zeit])

    respond_to do |format|
      if @zeit.save
        flash[:notice] = 'Zeit was successfully created.'
        format.html { redirect_to(@zeit) }
        format.xml  { render :xml => @zeit, :status => :created, :location => @zeit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zeit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /zeiten/1
  # PUT /zeiten/1.xml
  def update
    @zeit = Zeit.find(params[:id])

    respond_to do |format|
      if @zeit.update_attributes(params[:zeit])
        flash[:notice] = 'Zeit was successfully updated.'
        format.html { redirect_to(@zeit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zeit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /zeiten/1
  # DELETE /zeiten/1.xml
  def destroy
    @zeit = Zeit.find(params[:id])
    @zeit.destroy

    respond_to do |format|
      format.html { redirect_to(zeiten_url) }
      format.xml  { head :ok }
    end
  end
end
