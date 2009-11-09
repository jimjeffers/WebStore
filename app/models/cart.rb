require 'digest/sha1'

class Cart < ActiveRecord::Base
  # Relationships
  belongs_to :user
  has_many :line_items
  
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end
  def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end
end
