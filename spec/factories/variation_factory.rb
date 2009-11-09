Factory.sequence :sku do |n|
  "ASU-#{n}"
end

Factory.define :variation, :class => Variation do |f|
  f.sku Factory.next(:sku)
end

Factory.define :shirt_girls_small_red, :class => Variation do |f|
  f.sku Factory.next(:sku)
  f.product { |p| p.association(:product_shirt) }
  f.color { |c| c.association(:color_red) }
  f.garment_size { |gs| gs.association(:girls_small) }
end

Factory.define :shorts_guys_large_blue, :class => Variation do |f|
  f.sku Factory.next(:sku)
  f.product { |p| p.association(:product_shorts) }
  f.color { |c| c.association(:color_blue) }
  f.garment_size { |gs| gs.association(:guys_large) }
end

Factory.define :jacket_guys_medium_yellow, :class => Variation do |f|
  f.sku Factory.next(:sku)
  f.product { |p| p.association(:product_jacket) }
  f.color { |c| c.association(:color_yellow) }
  f.garment_size { |gs| gs.association(:guys_medium) }
end