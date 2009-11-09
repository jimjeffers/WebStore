Factory.define :product, :class => Product do |f|
  f.name 'ASU Product'
  f.price 25.00
end

Factory.define :product_shirt, :parent => :product do |f|
  f.name 'ASU T-Shirt'
end

Factory.define :product_shorts, :parent => :product do |f|
  f.name 'ASU Shorts'
end

Factory.define :product_jacket, :parent => :product do |f|
  f.name 'ASU Jacket'
end

Factory.define :product_hat, :parent => :product do |f|
  f.name 'ASU Hat'
end