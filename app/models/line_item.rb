class LineItem < ActiveRecord::Base
  # Relationships
  belongs_to :cart
  belongs_to :variation
  
  # Validations
  validates_presence_of :variation_id
  validates_presence_of :quantity
  
  # Scopes
  #default_scope :include => {:variations => [:product, :garment_size, :color]}
  
  # Hooks
  def before_create
    self.price = variation.product.price
  end
  
  def destroy
    unless cart.nil? || cart.ordered?
    end
  end
end
