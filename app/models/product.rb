class Product < ActiveRecord::Base
  has_many :categories, :through => :categorizations
  has_many :categorizations
  has_many :colors
  acts_as_taggable
  
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
    Category.all(:conditions => "id NOT IN (#{categories.map{|c| c.id}.join(', ')})")
  end
end
