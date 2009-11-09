Factory.define :category, :class => Category do |f|
  f.name 'Category'
end

Factory.define :category_shirts, :parent => :category do |f|
  f.name 'T-Shirts'
end

Factory.define :category_shorts, :parent => :category do |f|
  f.name 'Shorts'
end