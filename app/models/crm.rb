class CRM < ActionMailer::Base

  def order_confirm(order)
    subject "[Cactus Sports] Order ##{order.id}"
    recipients order.email
    from "site@cactussports.com"
    bcc ["cactussports1@gmail.com", "tlscoma@gmail.com"]
    reply_to "cactussports1@gmail.com"
    sent_on Time.now
    
    body[:order] = order
    body[:line_items] = order.cart.line_items
  end
  
  def order_tracking(order)
    subject "[Cactus Sports] Order ##{order.id} - Shipping Confirmation"
    recipients order.email
    from "site@cactussports.com"
    bcc ["cactussports1@gmail.com", "tlscoma@gmail.com"]
    reply_to "cactussports1@gmail.com"
    sent_on Time.now
    
    body[:order] = order
    body[:line_items] = order.cart.line_items
  end

end
