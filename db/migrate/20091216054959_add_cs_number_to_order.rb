class AddCsNumberToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :cs_number, :integer
    add_index :orders, :cs_number
    Order.all.each do |order|
      order.update_attribute(:cs_number,order.id+18438)
    end
  end

  def self.down
    remove_index :orders, :column => :cs_number
    remove_column :orders, :cs_number
  end
end
