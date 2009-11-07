class StoreController < ApplicationController
  
  # Displays default storefront.
  def index
    @guys_categories = Category.all
    @girls_categories = Category.all
  end
  
end
