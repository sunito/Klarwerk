class DiaquenController < ApplicationController
  # GET /diaquen
  # GET /diaquen.xml
  def index
    @diaquen = Diaque.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diaquen }
    end
  end

  # GET /diaquen/1
  # GET /diaquen/1.xml
  def show
    @diaque = Diaque.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diaque }
    end
  end

  # GET /diaquen/new
  # GET /diaquen/new.xml
  def new
    @diaque = Diaque.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diaque }
    end
  end

  # GET /diaquen/1/edit
  def edit
    @diaque = Diaque.find(params[:id])
  end

  # POST /diaquen
  # POST /diaquen.xml
  def create
    @diaque = Diaque.new(params[:diaque])

    respond_to do |format|
      if @diaque.save
        flash[:notice] = 'Diaque was successfully created.'
        format.html { redirect_to(@diaque) }
        format.xml  { render :xml => @diaque, :status => :created, :location => @diaque }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diaque.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diaquen/1
  # PUT /diaquen/1.xml
  def update
    @diaque = Diaque.find(params[:id])

    respond_to do |format|
      if @diaque.update_attributes(params[:diaque])
        flash[:notice] = 'Diaque was successfully updated.'
        format.html { redirect_to(@diaque) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diaque.errors, :status => :unprocessable_entity }
      end
    end
  end

   def ajax_update
    if params[:farbe] != nil 
      @farbe = params[:farbe]
      @diaque = Diaque.find(params[:id])
      @diaque.farbe = @farbe
      @diaque.save!
    end 
    redirect_to :controller => "diagramme", :action => "render_chart_update", :id => @diaque.diagramm_id
    
  end


  # DELETE /diaquen/1
  # DELETE /diaquen/1.xml
  def destroy
    @diaque = Diaque.find(params[:id])
    @diaque.destroy

    respond_to do |format|
      format.html { redirect_to(diaquen_url) }
      format.xml  { head :ok }
    end
  end
end
