class Categorization < ActiveRecord::Base
  belongs_to :product
  belongs_to :category
  validates_uniqueness_of :category_id, :scope => :product_id
end
