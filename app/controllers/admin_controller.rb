class AdminController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  require_role [:user,:manager]
  
  def index
    redirect_to :action => 'dashboard'
  end
  
  def dashboard
    @products = Product.all
    @categories = Category.all
    @orders = Order.to_be_processed
  end
  
end
