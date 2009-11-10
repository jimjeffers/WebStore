require 'digest/sha1'

class Cart < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :line_items
  
  # Hooks
  def before_create
    self.cart_token = make_token
  end
  
  # Returns the running total based off the products and quantities of a given product in the cart.
  def running_total
    self.line_items( 
      :include => {:variation => :product} 
    ).inject(0) { |total, line_item| 
      total + (line_item.variation.product.price * line_item.quantity)
    }
  end
  
  # Returns the count of items in the cart based off the line_items quantities.
  def item_count
    self.line_items.inject(0) { |total, line_item| total + line_item.quantity }
  end
  
  protected
  # Takes a set of arguments and generates a SHA1 hash.
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
  # Generates a token from the current time and a random number.
  def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end
end
