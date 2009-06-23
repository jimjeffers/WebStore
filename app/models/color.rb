class Color < ActiveRecord::Base
  has_many :variations
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :hex_value
  
  def hex_value=(val)
    val = "##{val}" if (val =~ /#/).nil?
    write_attribute(:hex_value,val)
  end
end
