class Color < ActiveRecord::Base
  has_many :garment_sizes
  has_many :color_options
end
