class Category < ActiveRecord::Base
  # Plugins
  acts_as_taggable
  acts_as_paranoid
  has_guid :name
  
  # Relationships
  has_many :products, :through => :categorizations
  has_many :categorizations
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Returns a whitespace free slug for markup or SEO purposes.
  def slug
    name.split(' ').join('-')
  end
end
