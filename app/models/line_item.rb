class LineItem < ActiveRecord::Base
  include AASM
  
  # Relationships
  belongs_to :cart
  belongs_to :variation
  
  # Validations
  validates_presence_of :variation_id
  validates_presence_of :quantity
  
  # Scopes
  default_scope :conditions => ["line_items.deleted_at IS ?",nil]
  named_scope :not_deleted, :conditions => ["line_items.deleted_at IS ?",nil]
  
  # States (via aasm)
  aasm_initial_state :new
  aasm_state :new
  aasm_state :ordered
  
  aasm_event :close do
    transitions :to => :ordered, :from => [:new]
  end
  
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
  
  # Find the variation even if it was deleted if this line item was part of a closed order.
  def variation
    if ordered?
      Variation.find_even_if_deleted(variation_id)
    else
      begin
        Variation.find(variation_id)
      rescue
        nil
      end
    end
  end
  
  # Safe destroy the item if it is not on an ordered cart.
  def destroy
    unless cart.nil? || cart.ordered? || ordered?
      self.update_attribute(:deleted_at, Time.now.utc)
    end
  end
  
  # Performs a destroy unless the item belongs to an order that has already shipped.
  def late_destroy
    unless cart.order.shipped?
      self.update_attribute(:deleted_at, Time.now.utc)
    end
  end
  
  # Returns true if the line item is not closed but is missing a variation.
  def invalid?
    (new? && variation.nil?)
  end
end
