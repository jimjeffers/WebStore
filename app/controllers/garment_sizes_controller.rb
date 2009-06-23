class GarmentSizesController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  # GET /garment_sizes
  # GET /garment_sizes.xml
  def index
    @garment_sizes = GarmentSize.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @garment_sizes }
    end
  end

  # GET /garment_sizes/1
  # GET /garment_sizes/1.xml
  def show
    @garment_size = GarmentSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @garment_size }
    end
  end

  # GET /garment_sizes/new
  # GET /garment_sizes/new.xml
  def new
    @garment_size = GarmentSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @garment_size }
    end
  end

  # GET /garment_sizes/1/edit
  def edit
    @garment_size = GarmentSize.find(params[:id])
  end

  # POST /garment_sizes
  # POST /garment_sizes.xml
  def create
    @garment_size = GarmentSize.new(params[:garment_size])

    respond_to do |format|
      if @garment_size.save
        flash[:notice] = 'GarmentSize was successfully created.'
        format.html { redirect_to(garment_sizes_path) }
        format.xml  { render :xml => @garment_size, :status => :created, :location => @garment_size }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @garment_size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /garment_sizes/1
  # PUT /garment_sizes/1.xml
  def update
    @garment_size = GarmentSize.find(params[:id])

    respond_to do |format|
      if @garment_size.update_attributes(params[:garment_size])
        flash[:notice] = 'GarmentSize was successfully updated.'
        format.html { redirect_to(garment_sizes_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @garment_size.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /garment_sizes/1
  # DELETE /garment_sizes/1.xml
  def destroy
    @garment_size = GarmentSize.find(params[:id])
    @garment_size.destroy

    respond_to do |format|
      format.html { redirect_to(garment_sizes_url) }
      format.xml  { head :ok }
    end
  end
end
