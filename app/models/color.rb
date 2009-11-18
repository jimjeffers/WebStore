class Color < ActiveRecord::Base
  # Relationships
  has_many :variations, :dependent => :destroy
  
  # Validations
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :hex_value
  
  # Scopes
  default_scope :conditions => ["colors.deleted_at IS ?",nil]
  named_scope :deleted, :conditions => ['colors.deleted_at IS NOT ?',nil]
  
  # ----------------------------------------------------------
  # Class Methods
    
  # Find all items included those that have been deleted.
  def self.all_including_deleted
    self.with_exclusive_scope { find(:all) }
  end
  
  # Show only items that have already been deleted
  def self.deleted
    self.with_exclusive_scope { find(:all, :conditions => ["deleted_at IS NOT ?",nil]) }
  end
  
  # ----------------------------------------------------------
  # Instance Methods
  
  # Prefixes the assigned value with a hash symbol (#) when assigned (only if it doesn't have one already!) 
  def hex_value=(val)
    val = "##{val}" if (val =~ /#/).nil?
    write_attribute(:hex_value,val)
  end
  
  # Paranoid destroy behavior.
  def destroy
    if self.variations.length > 0
      errors.add_to_base("You cannot delete this color yet. There are #{self.variations.length} product variations that depend on it.")
    else
      self.update_attribute(:deleted_at, Time.now.utc)
    end
  end
end
