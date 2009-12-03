class OrdersController < ApplicationController
  before_filter :login_required
  layout 'admin'
  
  def index
    @orders = Order.currently('paid').ordered('created_at ASC')
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def capture
    @order = @order.find(params[:id])
    @order.update_attributes(params[:order])
  end
  
  def ship
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    if !@order.tracking_number.blank?
      if @order.order_shipped!
        CRM.deliver_order_tracking(@order)
      end
    else
      flash[:error] = "Order could not be shipped you did not enter a tracking number!"
    end
    render :action => "show"
  end
  
  def search
    @search = params[:order_term]
    @orders = Order.search(@search)
    
    render :action => 'index'
  end
end