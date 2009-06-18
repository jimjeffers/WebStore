class CleanupGarmentSizeModel < ActiveRecord::Migration
  def self.up
    remove_column :garment_sizes, :price
    remove_column :garment_sizes, :color_id
    add_column :garment_sizes, :gender, :string
  end

  def self.down
    remove_column :garment_sizes, :gender
    add_column :garment_sizes, :price, :float
    add_column :garment_sizes, :color_id, :integer
  end
end