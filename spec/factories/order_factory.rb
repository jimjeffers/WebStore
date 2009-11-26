Factory.define :order, :class => Order do |f|
  f.shipping_first    "John"
  f.shipping_last     "Doe"
  f.shipping_1        "944 S. Mill Dr."
  f.shipping_city     "Tempe"
  f.shipping_state    "AZ"
  f.shipping_zip      "85281"
  f.billing_1         "944 S. Mill Dr."
  f.billing_city      "Tempe"
  f.billing_state     "AZ"
  f.billing_zip       "85281"
  f.shipping_method   "standard"
end

Factory.define :order_with_shipping_outside_of_az, :parent => :order do |f|
  f.shipping_state "CA"
end

Factory.define :order_with_billing_outside_of_az, :parent => :order do |f|
  f.billing_state "CA"
end

Factory.define :order_with_shipping_and_billing_outside_of_az, :parent => :order do |f|
  f.shipping_state "CA"
  f.billing_state "CA"
end

Factory.define :order_with_second_day, :parent => :order do |f|
  f.shipping_method "2nd day"
end