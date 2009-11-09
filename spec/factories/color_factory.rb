Factory.define :color_red, :class => Color do |f|
  f.name 'Red'
  f.hex_value 'FF0000'
end

Factory.define :color_yellow, :class => Color do |f|
  f.name 'Yellow'
  f.hex_value 'FFFF00'
end

Factory.define :color_blue, :class => Color do |f|
  f.name 'Blue'
  f.hex_value '0000FF'
end

Factory.define :color_green, :class => Color do |f|
  f.name 'Green'
  f.hex_value '00FF00'
end