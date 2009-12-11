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
    :pets => "pets"
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
  SHIPPING_RATES = [[25,6],[50,8],[70,9],[100,11],[150,13],[200,15],[200,18]]
  
  # Calculates the shipping cost based on the sub total.
  def self.calculate_shipping_cost(sub_total,method="standard")
    shipping_cost = SHIPPING_MINIMUM
    SHIPPING_RATES.each do |rate,cost|
      shipping_cost = cost if sub_total.to_f > rate
    end
    return shipping_cost + SHIPPING_COSTS[method]
  end
end