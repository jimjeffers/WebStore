class GarmentSize < ActiveRecord::Base
  # Relationships
  has_many :variations
  # Validations
  validates_uniqueness_of :name, :scope => :gender
  validates_presence_of :name
end