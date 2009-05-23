class Category < ActiveRecord::Base
  has_many :products, :through => :categorizations
  has_many :categorizations
  acts_as_taggable
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  # Returns a whitespace free slug for markup or SEO purposes.
  def slug
    name.split(' ').join('-')
  end
end
