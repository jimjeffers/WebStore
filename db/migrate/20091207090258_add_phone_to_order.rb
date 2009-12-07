class AddPhoneToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :phone, :string
  end

  def self.down
    remove_column :orders, :phone
  end
end
