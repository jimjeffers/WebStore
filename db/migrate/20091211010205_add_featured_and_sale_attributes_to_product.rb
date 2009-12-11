class AddFeaturedAndSaleAttributesToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :featured, :boolean, :default => false
    add_column :products, :sale_price, :float
  end

  def self.down
    remove_column :products, :sale_price
    remove_column :products, :featured
  end
end
