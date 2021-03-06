class Variation < ActiveRecord::Base
  include AASM
  
  # Relationships
  belongs_to :garment_size
  belongs_to :color
  belongs_to :product
  has_many :line_items
  
  # Validations
  validates_uniqueness_of :color_id, :scope => [:product_id, :garment_size_id]
  validates_uniqueness_of :garment_size_id, :scope => [:product_id, :color_id]
  validates_uniqueness_of :sku, :scope => :deleted_at
  validates_presence_of :sku
  
  # Scopes
  default_scope :conditions => ["variations.deleted_at IS ?",nil], 
                :order => "colors.name ASC, garment_sizes.name ASC", 
                :include => [:color, :garment_size]
  
  named_scope :not_deleted, {:conditions => ['variations.deleted_at IS ?',nil]}
  
  named_scope :all_with_gender, lambda {|gender| {:conditions => ['gender = ?',gender]} }
  named_scope :available, {:conditions => ['variations.aasm_state = "in_stock"']}
  
  # States (via aasm)
  aasm_initial_state :in_stock
  aasm_state :in_stock
  aasm_state :out_of_stock
  
  aasm_event :ran_out do
    transitions :to => :out_of_stock, :from => [:in_stock]
  end
  
  aasm_event :got_in do
    transitions :to => :in_stock, :from => [:out_of_stock]
  end
  
  aasm_event :toggle_availability do
    transitions :to => :in_stock, :from => :out_of_stock
    transitions :to => :out_of_stock, :from => :in_stock
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
  
  # Finds itself even if it has been deleted.
  def self.find_even_if_deleted(id)
    self.with_exclusive_scope { find(id) }
  end
  
  # It should find a product even if it's been deleted
  def product
    Product.find_even_if_deleted(product_id)
  end
  
  # ----------------------------------------------------------
  # Instance Methods
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
end