class AddPriceToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :float
  end

  def self.down
    remove_column :line_items, :price
  end
end
