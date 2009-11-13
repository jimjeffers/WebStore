class AddDeletedAtToSizeColorAndVariation < ActiveRecord::Migration
  def self.up
    add_column :variations, :deleted_at, :timestamp, :default => nil
    add_column :garment_sizes, :deleted_at, :timestamp, :default => nil
    add_column :colors, :deleted_at, :timestamp, :default => nil
  end

  def self.down
    remove_column :colors, :deleted_at
    remove_column :garment_sizes, :deleted_at
    remove_column :variations, :deleted_at
  end
end
