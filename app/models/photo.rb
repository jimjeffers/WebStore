class Photo < ActiveRecord::Base
  # Plugins
  acts_as_paranoid
  
  # Relationships
  belongs_to :product
  belongs_to :variation  
end
