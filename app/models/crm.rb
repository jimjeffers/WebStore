class CRM < ActionMailer::Base

  def order_confirm(order)
    subject "[Cactus Sports] Order ##{order.id}"
    recipients order.email
    from "do-not-reply@cactussports.com"
    sent_on Time.now
    
    body[:order] = order
    body[:line_items] = order.cart.line_items
  end
  
  def hello_world(sent_at = Time.now)
    subject    'Notifier#hello_world'
    recipients 'shout@jimjeffers.com'
    from       'support@usaenergyguide.com'
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
