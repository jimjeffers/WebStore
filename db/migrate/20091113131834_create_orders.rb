class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :ip
      t.string :error_message
      t.string :aasm_state, :default => 'pending'
      t.string :email
      t.string :shipping_first
      t.string :shipping_last
      t.string :shipping_1
      t.string :shipping_2
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.string :billing_first
      t.string :billing_last
      t.string :billing_1
      t.string :billing_2
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip
      t.integer :amount
      t.references :cart
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end