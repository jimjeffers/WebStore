class Brand < ActiveRecord::Base
  # Plugins
  has_attached_file :logo, :styles => { :medium => "100x100#", :thumb => "25x25#" }
  
  # Relationships
  has_many :products
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
end
