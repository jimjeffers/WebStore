class Color < ActiveRecord::Base
  has_many :garment_sizes
  belongs_to :product
end
