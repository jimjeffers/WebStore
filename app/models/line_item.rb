class LineItem < ActiveRecord::Base
  # Relationships
  belongs_to :cart
  belongs_to :variation
end
