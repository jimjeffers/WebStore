class StoreController < ApplicationController
  before_filter :get_items_from_params
  before_filter :get_segmented_categories
  before_filter :get_categories_by_method
  
  # Displays default storefront.
  def index
    @products = Product.sellable.limited(20)
  end
  
  # Displays search results.
  def search
    @products = Product.find_tagged_with(params[:search])
    render :action => "index"
  end
  
  # Displays a specific product.
  def product
    # Incase you're confused about @product it's happening with a before filter: get_items_from_params
    if @method == Store::METHODS[:brand]
      @products = @category.products.sellable.limited(5)
      @variations = @product.variations.not_deleted
    else
      @products = @category.products.all_with_gender(@method).sellable.limited(5)
      @variations = @product.variations.not_deleted.all_with_gender(@method)
    end
    @line_item = LineItem.new
  end
  
  # Displays all products of a specific category.
  def category
    unless @method == Store::METHODS[:brand]
      @products = @category.products.all_with_gender(@method).sellable
    else
      @products = @category.products.sellable
    end
  end
  
  # Adds a line_item to the user's cart. Creates a cart if
  # the user does not have one in their session.
  def add_to_cart
    if cookies[:cart_token].nil? || cookies[:cart_token].blank?
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
    debugger
    if @cart and @cart.line_items.include?(@line_item)
      @cart.remove_line_item(@line_item)
    end
    redirect_to :action => 'cart'
  end
  
  # Displays the items in the current users shopping cart.
  def cart
    @cart.purge!
    @line_items = @cart.line_items
  end
  
  # Displays checkout form.
  def checkout
    @line_items = @cart.line_items
    @order = Order.new
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
  end
  
  # Returns segmented categories for navigation purposes.
  def get_segmented_categories
    @guys_categories = Category.all_with_gender(Store::METHODS[:guys])
    @girls_categories = Category.all_with_gender(Store::METHODS[:girls])
    @kids_categories = Category.all_with_gender(Store::METHODS[:kids])
    @pets_categories = Category.all_with_gender(Store::METHODS[:pets])
    @gifts_categories = Category.all_with_gender(Store::METHODS[:gifts])
    @brands = Brand.all
  end
  
  # Returns a list of categories dependent on the search method (a string) stored in @method
  def get_categories_by_method
    @categories = case @method
      when Store::METHODS[:guys]  then @guys_categories
      when Store::METHODS[:girls] then @girls_categories
      when Store::METHODS[:kids]  then @kids_categories
      when Store::METHODS[:pets]  then @pets_categories
      when Store::METHODS[:gifts] then @gifts_categories
      when Store::METHODS[:brand] then Brand.all
      when nil then Category.all
    end
  end
end