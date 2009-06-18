class VariationsController < ApplicationController
  # GET /variations
  # GET /variations.xml
  def index
    @variations = Variation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @variations }
    end
  end

  # GET /variations/1
  # GET /variations/1.xml
  def show
    @variation = Variation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @variation }
    end
  end

  # GET /variations/new
  # GET /variations/new.xml
  def new
    @variation = Variation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @variation }
    end
  end

  # GET /variations/1/edit
  def edit
    @variation = Variation.find(params[:id])
  end

  # POST /variations
  # POST /variations.xml
  def create
    @variation = Variation.new(params[:variation])

    respond_to do |format|
      if @variation.save
        flash[:notice] = 'Variation was successfully created.'
        format.html { redirect_to(@variation) }
        format.xml  { render :xml => @variation, :status => :created, :location => @variation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @variation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /variations/1
  # PUT /variations/1.xml
  def update
    @variation = Variation.find(params[:id])

    respond_to do |format|
      if @variation.update_attributes(params[:variation])
        flash[:notice] = 'Variation was successfully updated.'
        format.html { redirect_to(@variation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @variation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /variations/1
  # DELETE /variations/1.xml
  def destroy
    @variation = Variation.find(params[:id])
    @variation.destroy

    respond_to do |format|
      format.html { redirect_to(variations_url) }
      format.xml  { head :ok }
    end
  end
end
