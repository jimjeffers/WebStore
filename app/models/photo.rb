class Photo < ActiveRecord::Base
  belongs_to :product
  belongs_to :variation
  
  
  acts_as_paranoid
  
end
