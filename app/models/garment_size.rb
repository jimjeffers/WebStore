class GarmentSize < ActiveRecord::Base
  # Relationships
  has_many :variations, :dependent => :destroy
  
  # Validations
  validates_uniqueness_of :name, :scope => [:gender, :deleted_at]
  validates_presence_of :name
  
  # Scopes
  default_scope :conditions => ["garment_sizes.deleted_at IS ?",nil]
  named_scope :deleted, :conditions => ['garment_sizes.deleted_at IS NOT ?',nil]
  
  # Paranoid destroy behavior.
  def destroy
    if self.variations.length > 0
      errors.add_to_base("You cannoy delete this item yet. There are #{self.variations.length} product variations that depend on it.")
    else
      self.update_attribute(:deleted_at, Time.now.utc)
    end
  end
end