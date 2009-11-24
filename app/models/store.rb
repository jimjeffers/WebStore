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
  SALES_TAX_STATE = "AZ"
  SHIPPING_METHODS = ["Standard", "Expedited"]
  SHIPPING_RATES = {"Standard" => 9.99, "Expedited" => 19.99}
end