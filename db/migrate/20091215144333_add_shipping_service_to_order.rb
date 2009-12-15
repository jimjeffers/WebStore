class AddShippingServiceToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_service, :string
  end

  def self.down
    remove_column :orders, :shipping_service
  end
end
