class StoreController < ApplicationController
  ssl_required :checkout, :confirm, :purchase unless ENV["RAILS_ENV"] == "development"
  before_filter :get_items_from_params
  before_filter :get_segmented_categories
  before_filter :get_categories_by_method
  before_filter :hide_newsletter_form, :only => [:checkout,:confirm]
  
  # Displays default storefront.
  def index
    @products = Product.featured.ordered.sellable.paginate :page => params[:page], :per_page => @site_settings.products_per_page * Store::ROW_SIZE[:home]
  end
  
  # Displays search results.
  def search
    @products = Product.search(params[:search]).ordered.paginate :page => params[:page], :per_page => @site_settings.products_per_page* Store::ROW_SIZE[:search]
    render :action => "index"
  end
  
  # Displays a specific product.
  def product
    if @product.nil?
      render_404
    else
      if @category.nil?
        @category = @product.categories.first
      end
      # Incase you're confused about @product it's happening with a before filter: get_items_from_params
      if @method == Store::METHODS[:brand]
        @products = @category.products.sellable.limited(5)
        @variations = @product.variations.not_deleted.available
      else
        @products = @category.products.all_with_gender(@method).sellable.limited(5)
        @variations = @product.variations.not_deleted.available.all_with_gender(@method)
      end
      @line_item = LineItem.new
    end
  end
  
  # Displays all products of a specific category.
  def category
    if @method == Store::METHODS[:brand]
      @products = @category.products.ordered.sellable.paginate(:page => params[:page], :per_page => @site_settings.products_per_page * Store::ROW_SIZE[:brand])
    elsif @method == Store::METHODS[:sales]
      @products = Product.category_ordered(@category).on_sale.sellable.paginate(:page => params[:page], :per_page => @site_settings.products_per_page * Store::ROW_SIZE[:category])
    else
      @products = Product.category_ordered(@category).all_with_gender(@method).sellable.paginate(:page => params[:page], :per_page => @site_settings.products_per_page * Store::ROW_SIZE[:category])
    end
  end
  
  # Adds a line_item to the user's cart. Creates a cart if
  # the user does not have one in their session.
  def add_to_cart
    if cookies[:cart_token].nil? || cookies[:cart_token].blank? || @cart.nil?
      @cart = Cart.create
      cookies[:cart_token] = {:value => @cart.cart_token, :expires => 1.month.from_now}
    end
    @line_item = LineItem.new(params[:line_item])
    if @line_item.valid? and @cart.line_items << @line_item
      redirect_to :action => 'cart'
    else
      render :action => product
    end
  end
  
  # Removes a specific line item from the current user's cart.
  def remove_from_cart
    @line_item = LineItem.find(params[:id])
    if @cart and @cart.line_items.include?(@line_item)
      @cart.remove_line_item(@line_item)
    end
    redirect_to :action => 'cart'
  end
  
  # Displays the items in the current users shopping cart.
  def cart 
    @cart.purge! if !@cart.nil?
    @line_items = @cart.line_items.not_deleted if !@cart.nil?
  end
  
  # Displays checkout form.
  def checkout
    redirect_to '/' if @cart.nil?
    @cart.purge!
    @line_items = @cart.line_items.not_deleted
    @order = Order.new(params[:order])
  end
  
  # Displays order with sales tax and allows for the selection of a shipping method.
  def confirm
    redirect_to '/' if @cart.nil?
    @cart.purge!
    @line_items = @cart.line_items.not_deleted
    @order = Order.new(params[:order])
        
    @seo_content_toggle, @newsletter_toggle = [true,true]
    if @order.has_problems_with?(Order::PREORDER_FIELDS)
      render :action => "checkout" 
    else
      @order.errors.clear
      @order.calculate_cart(@cart)
    end
  end
  
  # Creates order and authorizes payment.
  def purchase
    @cart.purge!
    @line_items = @cart.line_items.not_deleted
    @order = Order.new(params[:order])
    
    if @order.valid?
      if @order.process_cart(@cart)
        CRM.deliver_order_confirm(@order)
        render :action => "purchase"
      else
        render :action => "confirm"
        @seo_content_toggle, @newsletter_toggle = [true,true]
      end
    else
      render :action => "confirm"
      @seo_content_toggle, @newsletter_toggle = [true,true]
    end
  end
  
  def not_found
    render_404
  end
  
  protected
  # Retrieves the users search method, category, brand, or product if it exists.
  def get_items_from_params
    [params[:method],params[:category_guid],params[:product_guid]].each do |param|
      param.downcase! unless param.nil?
    end
    @method = params[:method] || nil
    if @method == Store::METHODS[:brand]
      @category = Brand.find_by_guid(params[:category_guid]) || nil
    else
      @category = Category.find_by_guid(params[:category_guid]) || nil
    end
    @product = Product.find_by_guid(params[:product_guid]) || nil
    @cart = Cart.find_by_cart_token(cookies[:cart_token]) || nil
    if @cart and @cart.ordered?
      @cart = nil
      cookies[:cart_token] = {:value => "nil", :expires => 1.day.from_now}
    end
  end
  
  # Returns segmented categories for navigation purposes.
  def get_segmented_categories
    unless  fragment_exist?(:controller => 'layout', :action => 'store', :action_suffix => "store_layout_search_and_nav") && 
            fragment_exist?(:controller => 'layout', :action => 'store', :action_suffix => "store_layout_footer") &&
            fragment_exist?(:controller => 'layout', :action => 'store', :action_suffix => "section_navigation")
      @guys_categories = Category.all_with_gender(Store::METHODS[:guys]) 
      @girls_categories = Category.all_with_gender(Store::METHODS[:girls])
      @kids_categories = Category.all_with_gender(Store::METHODS[:kids])
      @pets_categories = Category.all_with_gender(Store::METHODS[:pets])
      @gifts_categories = Category.all_with_gender(Store::METHODS[:gifts])
      @sale_categories = Category.all_with_sale_items
      @brands = Brand.all
    end
  end
  
  # Returns a list of categories dependent on the search method (a string) stored in @method
  def get_categories_by_method
    @categories = case @method
      when Store::METHODS[:guys]  then @guys_categories || Category.all_with_gender(Store::METHODS[:guys]) 
      when Store::METHODS[:girls] then @girls_categories || Category.all_with_gender(Store::METHODS[:girls])
      when Store::METHODS[:kids]  then @kids_categories || Category.all_with_gender(Store::METHODS[:kids])
      when Store::METHODS[:pets]  then @pets_categories || Category.all_with_gender(Store::METHODS[:pets])
      when Store::METHODS[:gifts] then @gifts_categories || Category.all_with_gender(Store::METHODS[:gifts])
      when Store::METHODS[:brand] then @brands || Brand.all
      when Store::METHODS[:sales] then @sale_categories || Category.all_with_sale_items
      when nil then Category.all
    end
  end
  
  # Sets boolean values ot hide the newsletter form incase it could become distracting.
  def hide_newsletter_form
    @seo_content_toggle, @newsletter_toggle = [true,true]
  end
end