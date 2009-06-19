class Product < ActiveRecord::Base
  has_many :categories, :through => :categorizations
  has_many :categorizations, :dependent => :destroy
  
  has_many :colors, :through => :variations
  has_many :garment_sizes, :through => :variations
  has_many :variations, :dependent => :destroy
  
  acts_as_taggable
  
  validates_presence_of :name
  validates_presence_of :price
  
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
    Category.all(:conditions => "id NOT IN (#{category_ids})")
  end
  
  protected
  # return a string containing NULL to prevent MySQL errors from IN () which does
  # not throw a SQL error in sqlite.
  def category_ids
    (categories.length > 0) ? categories.map{|c| c.id}.join(', ') : 'NULL'
  end
end
