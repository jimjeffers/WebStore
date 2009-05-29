class ColorOption < ActiveRecord::Base
  belongs_to :product
  belongs_to :color, :scope => :product_id
end
