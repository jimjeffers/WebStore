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
      @variations = @product.variations
    else
      @products = @category.products.all_with_gender(@method.capitalize).sellable.limited(5)
      @variations = @product.variations.all_with_gender(@method.capitalize)
    end
    @line_item = LineItem.new
  end
  
  # Displays all products of a specific category.
  def category
    unless @method == Store::METHODS[:brand]
      @products = @category.products.all_with_gender(@method.capitalize).sellable
    else
      @products = @category.products.sellable
    end
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
  end
  
  # Returns segmented categories for navigation purposes.
  def get_segmented_categories
    @guys_categories = Category.all_with_gender('Guys')
    @girls_categories = Category.all_with_gender('Girls')
    @brands = Brand.all
  end
  
  # Returns a list of categories dependent on the search method (a string) stored in @method
  def get_categories_by_method
    @categories = case @method
      when Store::METHODS[:guys] then @guys_categories
      when Store::METHODS[:girls] then @girls_categories
      when Store::METHODS[:brand] then Brand.all
      when nil then Category.all
    end
  end
end