# Stores constants for the store settings sitewide.
class Store
  # Constants
  MAX_QUANTITY = 10
  METHODS = {
    :brand => "brand", 
    :girls => "girls", 
    :guys => "guys", 
    :gifts => "gifts", 
    :kids => "kids",
    :pets => "pets",
    :sales => "sales"
  }
  ROW_SIZE = {
    :home => 5,
    :search => 5,
    :category => 4,
    :brand => 4
  }
  SALES_TAX_RATE = 0.081
  SALES_TAX_STATES = ["AZ","Arizona"]
  SHIPPING_METHODS = {"Standard" => "standard", "2nd Day  (add $18)" => "2nd day"}
  SHIPPING_COSTS = {"standard" => 0, "2nd day" => 18}
  SHIPPING_MINIMUM = 6
  SHIPPING_RATES = [[25,8],[50,9],[70,11],[100,13],[150,15],[200,18]]
  TRACKING_SITES = {
    :ups => "http://www.ups.com/tracking/tracking.html",
    :usps => "http://www.usps.com/shipping/trackandconfirm.htm",
    :fedex => "http://fedex.com/Tracking?cntry_code=us"
  }
  
  # Calculates the shipping cost based on the sub total.
  def self.calculate_shipping_cost(sub_total,method="standard",additional_from_products=0)
    shipping_cost = SHIPPING_MINIMUM
    SHIPPING_RATES.each do |rate,cost|
      shipping_cost = cost if sub_total.to_f > rate
    end
    return shipping_cost + SHIPPING_COSTS[method] + additional_from_products
  end
  
  # Show shipping costs dynamically
  def self.shipping_options_with_costs(sub_total,additional_from_products=0)
    [ ["Standard ($#{self.calculate_shipping_cost(sub_total,"standard",additional_from_products)})", "standard"], 
      ["2nd Day  ($#{self.calculate_shipping_cost(sub_total,"2nd day",additional_from_products)})", "2nd day"]]
  end
end