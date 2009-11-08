class StoreController < ApplicationController
  before_filter :get_segmented_categories
  
  # Displays default storefront.
  def index
    @products = Product.all
  end
  
  # Displays a specific product.
  def product
    @categories = Category.all
    @products = Product.all(:limit => 5)
  end
  
  protected
  # Returns segmented categories for navigation purposes.
  def get_segmented_categories
    @guys_categories = Category.all
    @girls_categories = Category.all
  end
end
