class GarmentSize < ActiveRecord::Base
  # Plugins
  has_guid :name
  
  # Relationships
  has_many :variations
  
  # Validations
  validates_uniqueness_of :name, :scope => :gender
  validates_presence_of :name
  
  # Scopes
  default_scope :conditions => ["deleted_at=?",nil]
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
end