class Category < ActiveRecord::Base
  has_many :products, :through => :categorizations
  has_many :categorizations
  acts_as_taggable
  
  # Returns a whitespace free slug for markup or SEO purposes.
  def slug
    name.split(' ').join('-')
  end
end
