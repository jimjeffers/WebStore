class AddSalesTaxAndShippingToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_method, :string
    add_column :orders, :shipping_cost, :integer
    add_column :orders, :sales_tax, :integer
    add_column :orders, :sub_total, :integer
  end

  def self.down
    remove_column :orders, :sub_total
    remove_column :orders, :sales_tax
    remove_column :orders, :shipping_cost
    remove_column :orders, :shipping_method
  end
end
