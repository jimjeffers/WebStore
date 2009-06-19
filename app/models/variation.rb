class Variation < ActiveRecord::Base
  belongs_to :garment_size
  belongs_to :color
  belongs_to :product
  validates_uniqueness_of :color_id, :scope => [:product_id, :garment_size_id]
  validates_uniqueness_of :garment_size_id, :scope => [:product_id, :color_id]
  validates_uniqueness_of :sku
  validates_presence_of :sku
end