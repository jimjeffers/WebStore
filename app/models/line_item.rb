class LineItem < ActiveRecord::Base
  # Relationships
  belongs_to :cart
  belongs_to :variation
  
  # Validations
  validates_presence_of :variation_id
  validates_presence_of :quantity
  
  # Scopes
  default_scope :conditions => ["line_items.deleted_at IS ?",nil]
  
  # ----------------------------------------------------------
  # Hooks
  
  # Grab the variation's product price.
  def before_create
    self.price = variation.product.price
  end
  
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
  
  # Safe destroy the item if it is not on an ordered cart.
  def destroy
    unless cart.nil? || cart.ordered?
      self.update_attribute(:deleted_at, Time.now.utc)
    end
  end
end
