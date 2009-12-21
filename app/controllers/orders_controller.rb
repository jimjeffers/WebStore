class OrdersController < ApplicationController
  before_filter :login_required
  require_role [:user,:manager]
  layout 'admin'
  
  def index
    @orders = Order.currently('paid').ordered('created_at ASC')+Order.currently('authorized')
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def capture
    @order = @order.find(params[:id])
    @order.update_attributes(params[:order])
  end
  
  def cancel
    @order = Order.find(params[:id])
    @order.order_canceled!
    redirect_to order_path(@order)
  end
  
  def ship
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    if !@order.tracking_number.blank? && !@order.shipping_service.blank?
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
  
  def remove_item
    @order = Order.find(params[:order_id])
    @order.remove_line_item(params[:id])
    redirect_to @order
  end
  
  def edit_item
    @order = Order.find(params[:order_id])
    @line_item = @order.cart.line_items.find(params[:id])
    @variations = @line_item.variation.product.variations
  end
  
  def update_item
    @order = Order.find(params[:order_id])
    @line_item = @order.cart.line_items.find(params[:id])
    unless @order.shipped?
      @line_item.update_attributes(params[:line_item])
      @order.calculate_amount
      @order.save
    end
    redirect_to @order
  end
end