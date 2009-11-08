class StoreController < ApplicationController
  before_filter :get_segmented_categories
  before_filter :get_items_from_params
  
  # Displays default storefront.
  def index
    @products = Product.all
  end
  
  # Displays a specific product.
  def product
    @categories = Category.all
    if params[:guid]
      @product = Product.find_by_guid(params[:guid])
    else
      @product = Product.find(params[:id])
    end
    @products = Product.all(:limit => 5)
  end
  
  protected
  # Returns segmented categories for navigation purposes.
  def get_segmented_categories
    @guys_categories = Category.all
    @girls_categories = Category.all
    @brands = Brand.all
  end
  
  # Retrieves the users search method, category, brand, or product if it exists.
  def get_items_from_params
    @method = params[:method]
    @product = Product.find_by_guid(params[:product_guid]) || nil
    @category = Category.find_by_guid(params[:category_guid]) || nil
    @brand = Brand.find_by_guid(params[:brand_guid]) || nil
  end
end
