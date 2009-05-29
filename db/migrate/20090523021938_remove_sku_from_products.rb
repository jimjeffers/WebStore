class RemoveSkuFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :sku
  end

  def self.down
    add_column :products, :sku, :string, :length => 32
  end
end
