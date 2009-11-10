class LineItem < ActiveRecord::Base
  # Relationships
  belongs_to :cart
  belongs_to :variation
  
  # Validations
  validates_presence_of :variation_id
  validates_presence_of :quantity
  
  # Hooks
  def before_create
    self.price = variation.product.price
  end
end
