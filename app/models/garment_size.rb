class GarmentSize < ActiveRecord::Base
  has_many :variations
  validates_uniqueness_of :name, :scope => :gender
end