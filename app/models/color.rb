class Color < ActiveRecord::Base
  # Relationships
  has_many :variations
  
  # Validations
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :hex_value
  
  # Scopes
  default_scope :conditions => ["deleted_at=?",nil]
  
  # Prefixes the assigned value with a hash symbol (#) when assigned (only if it doesn't have one already!) 
  def hex_value=(val)
    val = "##{val}" if (val =~ /#/).nil?
    write_attribute(:hex_value,val)
  end
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
end
