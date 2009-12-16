class AddAdditionalShippingCost < ActiveRecord::Migration
  def self.up
    add_column :products, :additional_shipping_cost, :float, :default => 0
  end

  def self.down
    remove_column :products, :additional_shipping_cost
  end
end
