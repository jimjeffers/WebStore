class FixDeletedAtOnProductAndVariation < ActiveRecord::Migration
  def self.up
    remove_column :products, :deleted_at
    add_column :products, :deleted_at, :timestamp, :default => nil
    remove_column :variations, :deleted_at
    add_column :variations, :deleted_at, :timestamp, :default => nil
  end

  def self.down
    remove_column :variations, :deleted_at
    add_column :variations, :deleted_at, :datetime
    remove_column :products, :deleted_at
    add_column :products, :deleted_at, :datetime
  end
end
