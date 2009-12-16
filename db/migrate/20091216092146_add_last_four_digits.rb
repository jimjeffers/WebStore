class AddLastFourDigits < ActiveRecord::Migration
  def self.up
    add_column :orders, :card_reference, :string
  end

  def self.down
    remove_column :orders, :card_reference
  end
end
