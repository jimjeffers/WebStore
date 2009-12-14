class Category < ActiveRecord::Base
  # Plugins
  acts_as_taggable
  has_guid :name
  
  # Relationships
  has_many :products, :through => :categorizations
  has_many :categorizations, :dependent => :destroy
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :deleted_at
  validates_uniqueness_of :guid, :scope => :deleted_at
  
  # Scopes
  default_scope :conditions => ["categories.deleted_at IS ?",nil]
  
  named_scope :all_with_gender, lambda { |gender| {
    :conditions => [' garment_sizes.gender = ? AND 
                      garment_sizes.deleted_at IS ? AND
                      variations.deleted_at IS ?',gender,nil,nil],
    :include => {:products => {:variations => :garment_size}} }
  }
  
  named_scope :all_with_sale_items, { :conditions => ['products.on_sale=? AND products.aasm_state=?',true,'in_stock'],
                                      :include => :products }
  
  # Show only items that have already been deleted
  def self.deleted
    self.with_exclusive_scope { find(:all, :conditions => ["deleted_at IS NOT ?",nil]) }
  end
  
  # Find an item even if it's no longer available 
  def self.find_even_if_deleted(id)
    self.with_exclusive_scope { find(id) }
  end
  
  # Returns a whitespace free slug for markup or SEO purposes.
  def slug
    name.split(' ').join('-')
  end
end
