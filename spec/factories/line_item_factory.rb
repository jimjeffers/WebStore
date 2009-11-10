Factory.define :line_item, :class => LineItem do |f|
  f.variation { |v| v.association(:shirt_girls_small_red) }
  f.quantity 1
  f.price 20.00
end