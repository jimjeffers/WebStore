class Product < ActiveRecord::Base
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
  default_scope :conditions => ["deleted_at=?",nil]
  named_scope :search, lambda { |term| {
    :conditions => ['variations.sku LIKE ? OR products.name LIKE ?',"%#{term}%","%#{term}%"],
    :include => :variations }
  }
  named_scope :all_with_gender, lambda { |gender| {
    :conditions => ['garment_sizes.gender = ?',gender],
    :include => {:variations => :garment_size} }
  }
  named_scope :sellable, { 
    :conditions => 'categorizations.product_id = products.id AND variations.product_id = products.id',
    :include => [:categorizations, :variations]
  }
  
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
    if variations.length > 0
      return variations.first.sku
    else
      return ""
    end
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
