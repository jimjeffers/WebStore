class Product < ActiveRecord::Base
  has_many :categories, :through => :categorizations
  has_many :categorizations
  has_many :colors
  acts_as_taggable
end
