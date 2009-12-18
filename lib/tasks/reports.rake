namespace :reports do
  desc "Returns a list of all orders in the system."
  task :orders => :environment do
    Order.all.each do |o| 
      puts "Amount: #{(o.sub_total || 0) / 100.to_f}"
      puts "Tax: #{(o.sales_tax || 0) / 100.to_f}"
      puts "Shipping: #{(o.shipping_cost || 0) / 100.to_f}"
      puts "Status: #{o.aasm_state}"
      puts "TOTAL CHARGED: #{(o.amount || 0) / 100.to_f}"
    end
  end
end