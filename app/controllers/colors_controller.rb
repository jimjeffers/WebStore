class ColorsController < ApplicationController
  before_filter :get_product
  before_filter :login_required
  # GET /colors
  # GET /colors.xml
  def index
    @colors = Color.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @colors }
    end
  end

  # GET /colors/1
  # GET /colors/1.xml
  def show
    @color = Color.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @color }
    end
  end

  # GET /colors/new
  # GET /colors/new.xml
  def new
    @color = Color.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @color }
      format.js { render :layout => 'lightbox'}
    end
  end

  # GET /colors/1/edit
  def edit
    @color = Color.find(params[:id])
  end

  # POST /colors
  # POST /colors.xml
  def create
    @color = Color.new(params[:color])
    respond_to do |format|
      if @product.colors << @color
        flash[:notice] = 'Color was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @color, :status => :created, :location => @color }
        format.js { render :layout => 'lightbox' }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
        format.js { render :layout => 'lightbox' }
      end
    end
  end

  # PUT /colors/1
  # PUT /colors/1.xml
  def update
    @color = Color.find(params[:id])

    respond_to do |format|
      if @color.update_attributes(params[:color])
        flash[:notice] = 'Color was successfully updated.'
        format.html { redirect_to(@color) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.xml
  def destroy
    @color = Color.find(params[:id])
    @color.destroy

    respond_to do |format|
      format.html { redirect_to(colors_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  # Gets the product associated with the color item.
  def get_product
    @product = Product.find(params[:product_id])
  end
end
