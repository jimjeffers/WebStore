class CRM < ActionMailer::Base

  def order_confirm(order)
    subject "[Cactus Sports] Order ##{order.id}"
    recipients order.email
    from "do-not-reply@cactussports.com"
    sent_on Time.now
    
    body[:order] = order
    body[:line_items] = order.cart.line_items
  end
  
  def order_tracking(order)
    subject "[Cactus Sports] Order ##{order.id} - Shipping Confirmation"
    recipients order.email
    from "do-not-reply@cactussports.com"
    sent_on Time.now
    
    body[:order] = order
    body[:line_items] = order.cart.line_items
  end

end
