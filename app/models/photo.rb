class Photo < ActiveRecord::Base
  belongs_to :product
  belongs_to :variation
  
  has_attachment :content_type => :image, 
                   :storage => :file_system, 
                   :max_size => 500.kilobytes,
                   :resize_to => '320x200>',
                   :thumbnails => { :thumb => '100x100>' }

  validates_as_attachment
  acts_as_paranoid
  
end
