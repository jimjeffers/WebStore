class Product < ActiveRecord::Base
  include AASM
  
  # Plugins
  has_guid :name
  has_attached_file :photo, :styles => { 
                                          :zoom => "600x600>",
                                          :display => "340x340#",
                                          :thumbnail => "100x100#",
                                          :showcase => "160x244#",
                                          :featured => "400x244#",
                                          :micro => "50x50#" }
  acts_as_taggable
  
  # Relationships
  has_many :categories, :through => :categorizations
  has_many :categorizations, :dependent => :destroy
  has_many :colors, :through => :variations
  has_many :garment_sizes, :through => :variations
  has_many :variations, :dependent => :destroy
  belongs_to :brand
  
  # Validations
  validates_presence_of :name
  validates_presence_of :price
  
  # Scopes
  default_scope :conditions => ["products.deleted_at IS ?",nil], 
                :include => [:variations], 
                :order => "variations.sku ASC"
                
  named_scope :deleted, :conditions => ['products.deleted_at IS NOT ?',nil]
  
  named_scope :search, lambda { |term| {
    :conditions => ['variations.sku LIKE ? OR products.name LIKE ?',"%#{term}%","%#{term}%"],
    :include => :variations }
  }
  
  named_scope :all_with_gender, lambda { |gender| {
    :conditions => ['garment_sizes.gender = ? AND garment_sizes.deleted_at IS ?',gender,nil],
    :include => {:variations => :garment_size} }
  }
  
  named_scope :sellable, { 
    :conditions => [' products.aasm_state="in_stock" AND 
                      categorizations.product_id = products.id AND 
                      variations.product_id = products.id AND 
                      variations.deleted_at IS ?',nil],
    :include => [:categorizations, :variations]
  }
  
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
  
  # Removes a category associated to this particular product.
  def remove_category(category_id)
    if !category_id.nil? && !(category = Category.find(category_id)).nil?
      categories.delete(category)
    end
  end
  
  # Adds a category associated to this particular product.
  def add_category(category_id)
    if !category_id.nil? && !(category = Category.find(category_id)).nil?
      categories << category unless categories.include?(category)
    end
  end
  
  # Returns categories that are not assigned to product.
  def potential_categories
    if categories.length > 0
      Category.all(:conditions => "id NOT IN (#{category_ids})")
    else
      Category.all
    end
  end
  
  # Returns the first sku associated with the product. If none we return an empty string.
  def sku
    if variations.not_deleted.length > 0
      return variations.not_deleted.first.sku
    else
      return ""
    end
  end
  
  # Returns the default method for the product
  def method
    @method || @method = self.variations.first.garment_size.gender.downcase if self.variations.length > 0 && !self.variations.first.garment_size.nil?
  end
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
  
  protected
  # return a string containing NULL to prevent MySQL errors from IN () which does
  # not throw a SQL error in sqlite.
  def category_ids
    (categories.length > 0) ? categories.map{|c| c.id}.join(', ') : 'NULL'
  end
  
end
