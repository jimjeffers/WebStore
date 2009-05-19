class AdminController < ApplicationController
  before_filter :login_required
  
  def index
    redirect_to :action => 'dashboard'
  end
  
  def dashboard
    @products = Product.all
    @categories = Category.all
  end
  
end
