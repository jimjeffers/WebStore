class Variation < ActiveRecord::Base
  # Plugins
  acts_as_paranoid
  
  # Relationships
  belongs_to :garment_size
  belongs_to :color
  belongs_to :product
  has_many :line_items
  
  # Validations
  validates_uniqueness_of :color_id, :scope => [:product_id, :garment_size_id]
  validates_uniqueness_of :garment_size_id, :scope => [:product_id, :color_id]
  validates_uniqueness_of :sku
  validates_presence_of :sku
  
  # Scopes
  default_scope :conditions => ["variations.deleted_at IS ?",nil], :order => "colors.name ASC, garment_sizes.name ASC", :include => [:color, :garment_size]
  named_scope :deleted, {:conditions => ['variations.deleted_at IS NOT ?',nil]}
  named_scope :all_with_gender, lambda {|gender| {:conditions => ['gender = ?',gender]} }
  
  # Paranoid destroy behavior.
  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end
end