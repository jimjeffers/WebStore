class OrdersController < ApplicationController
  before_filter :login_required
  
  layout 'admin'
  
  def index
    @orders = Order.currently('authorized').ordered('created_at ASC')
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def capture
    @order = @order.find(params[:id])
    @order.update_attributes(params[:order])
  end
end