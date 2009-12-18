namespace :transactions do
  desc "Creates a new fake transaction and attempts to authorize it."
  task :generate => :environment do
    order = Order.create!({
      "shipping_state" => "AZ",
      "billing_first" => "John",
      "shipping_first" => "Jane",
      "shipping_1" => "555 Somewhere Blvd.", 
      "shipping_2" => "Suite 512", 
      "billing_state" => "CA", 
      "billing_city" => "Hollywood", 
      "billing_1" => "123 E. Hollywood Dr.", 
      "amount" => 900, 
      "shipping_zip" => 85209,
      "billing_2" => "", 
      "cart_id" => Cart.last.id, 
      "sub_total" => 400, 
      "shipping_last" => "Doe", 
      "phone" => "455.545.4444", 
      "ip" => "127.0.0.1", 
      "billing_zip" => "90210", 
      "shipping_city" => "Mesa", 
      "billing_last" => "Doe", 
      "shipping_method" => "standard", 
      "shipping_cost" => 100, 
      "email" => "jim@sumocreations.com",
      :card_number => "4375989646208390",
      :verification_number => "123",
      :expiration_month => 12,
      :expiration_year => 2019
    })
    
    puts "Generated Order: #{order.id}"
    puts "Authorizing..."
    puts order.authorize_payment.to_yaml
  end
end