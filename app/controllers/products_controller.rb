class ProductsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  require_role [:user,:manager]
  
  cache_sweeper :categorization_sweeper
  cache_sweeper :showcase_sweeper, :only => [:sort, :toggle_featured, :toggle_availability]
  
  # GET /products
  # GET /products.xml
  def index
    get_categories
    if @category
      @products = @category.products.paginate :page => params[:page], :per_page => 75
    else
      @products = Product.paginate :page => params[:page], :per_page => 75
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @variations = @product.variations.not_deleted
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  # Removes a categorization from an instance of a product.
  def remove_category
    @product = Product.find(params[:product_id])
    @product.remove_category(params[:category_id])
    respond_to do |format|
      format.html { redirect_to product_path(@product) }
      format.js { render :json => {:action => "remove"}.to_json }
    end
  end
  
  # Adds a categorization to instance of a product.
  def add_category
    @product = Product.find(params[:product_id])
    @product.add_category(params[:category_id])
    respond_to do |format|
      format.html { redirect_to product_path(@product) }
      format.js { render :json => {:action => "add"} }
    end
  end
  
  def search
    get_categories
    @products = Product.search(params[:product_term]).paginate :page => params[:page], :per_page => @site_settings.products_per_page
    respond_to do |format|
      format.html { render :action => 'index' }
    end
  end
  
  def toggle_availability
    @product = Product.find(params[:product_id])
    @product.toggle_availability!
    respond_to do |format|
      format.html { redirect_to @product}
      format.js { render :json => {:status => @product.aasm_state}}
    end
  end
  
  def toggle_featured
    @product = Product.find(params[:product_id])
    @product.toggle_featured!
    respond_to do |format|
      format.html { redirect_to @product}
      format.js { render :json => {:status => (@product.featured?) ? "featured" : "not_featured"}}
    end
  end
  
  def sort
    @category = Category.find(params[:category_id]) unless params[:category_id].nil?
    if !@category.nil?
      @products = Product.category_ordered(@category)
    else
      @products = Product.ordered.featured
    end
  end
  
  # XHR /questions/update_order
  # Updates the order of the questions supplied in a post request.
  def update_order
    if params[:product]
      params[:product].each_with_index do |id,index|
        Product.find(id).update_attribute(:position,index)
      end
    elsif params[:categorization]
      params[:categorization].each_with_index do |id,index|
        Categorization.find(id).update_attribute(:position,index)
      end
    end
    respond_to do |format|
      format.js { render :text => 'Order successfully updated!' }
    end
  end
  
  protected
  # Grab all categories with products.
  def get_categories
    @categories = Category.all(:include => :products)
    @products_total = Product.count
    @category = Category.find(params[:category_id]) unless params[:category_id].nil?
  end
end