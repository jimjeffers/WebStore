Factory.define :garment_size, :class => GarmentSize do |f|
  f.name 'XL'
end

Factory.define :guys_small, :class => GarmentSize do |f|
  f.name 'S'
  f.gender 'Guys'
end

Factory.define :guys_medium, :class => GarmentSize do |f|
  f.name 'M'
  f.gender 'Guys'
end

Factory.define :guys_large, :class => GarmentSize do |f|
  f.name 'L'
  f.gender 'Guys'
end

Factory.define :girls_small, :class => GarmentSize do |f|
  f.name 'S'
  f.gender 'Girls'
end

Factory.define :girls_medium, :class => GarmentSize do |f|
  f.name 'M'
  f.gender 'Girls'
end

Factory.define :girls_large, :class => GarmentSize do |f|
  f.name 'L'
  f.gender 'Girls'
end