class AddPositioningToProductAndCategorizations < ActiveRecord::Migration
  def self.up
    add_column :products, :position, :integer, :default => 0
    add_column :categorizations, :position, :integer, :default => 0
  end

  def self.down
    remove_column :categorizations, :position
    remove_column :products, :position
  end
end
