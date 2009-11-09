class Variation < ActiveRecord::Base
  # Plugins
  acts_as_paranoid
  
  # Relationships
  belongs_to :garment_size
  belongs_to :color
  belongs_to :product
  
  # Validations
  validates_uniqueness_of :color_id, :scope => [:product_id, :garment_size_id]
  validates_uniqueness_of :garment_size_id, :scope => [:product_id, :color_id]
  validates_uniqueness_of :sku
  validates_presence_of :sku
  
  # Scopes
  default_scope :order => "colors.name ASC, garment_sizes.name ASC", :include => [:color, :garment_size]
  named_scope :all_with_gender, lambda {|gender| {:conditions => ['gender = ?',gender]} }
end