class AddOnSaleFlagToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :on_sale, :boolean, :default => false
  end

  def self.down
    remove_column :products, :on_sale
  end
end
