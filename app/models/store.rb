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
  SALES_TAX_RATE = 0.078
  SALES_TAX_STATES = ["AZ","Arizona"]
  SHIPPING_METHODS = {"Standard ($9.99)" => "standard", "Expedited  ($19.99)" => "expedited"}
  SHIPPING_RATES = {"standard" => 9.99, "expedited" => 19.99}
end