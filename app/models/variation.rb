class Variation < ActiveRecord::Base
  # Relationships
  belongs_to :garment_size
  belongs_to :color
  belongs_to :product
  has_many :line_items
  
  # Validations
  validates_uniqueness_of :color_id, :scope => [:product_id, :garment_size_id]
  validates_uniqueness_of :garment_size_id, :scope => [:product_id, :color_id]
  validates_uniqueness_of :sku
  validates_presence_of :sku
  
  # Scopes
  default_scope :conditions => ["variations.deleted_at IS ?",nil], 
                :order => "colors.name ASC, garment_sizes.name ASC", 
                :include => [:color, :garment_size]
  
  named_scope :not_deleted, {:conditions => ['variations.deleted_at IS ?',nil]}
  
  named_scope :all_with_gender, lambda {|gender| {:conditions => ['gender = ?',gender]} }
  named_scope :available, {:conditions => ['variations.aasm_state = "in_stock"']}
  
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
  
  def self.find_even_if_deleted(id)
    self.with_exclusive_scope { find(id) }
  end
  
  # ----------------------------------------------------------
  # Instance Methods
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
end