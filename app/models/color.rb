class Color < ActiveRecord::Base
  has_many :variations
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :hex_code
end
