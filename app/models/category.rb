class Category < ActiveRecord::Base
  # Plugins
  acts_as_taggable
  has_guid :name
  
  # Relationships
  has_many :products, :through => :categorizations
  has_many :categorizations, :dependent => :destroy
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Scopes
  default_scope :conditions => ["categories.deleted_at IS ?",nil]
  
  named_scope :all_with_gender, lambda { |gender| {
    :conditions => ['garment_sizes.gender = ? AND garment_sizes.deleted_at IS ?',gender,nil],
    :include => {:products => {:variations => :garment_size}} }
  }
  
  # Returns a whitespace free slug for markup or SEO purposes.
  def slug
    name.split(' ').join('-')
  end
end
