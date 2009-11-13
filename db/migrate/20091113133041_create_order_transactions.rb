class CreateOrderTransactions < ActiveRecord::Migration
  def self.up
    create_table :order_transactions do |t|
      t.integer :amount
      t.boolean :success
      t.string :reference
      t.string :message
      t.string :action
      t.text :params
      t.boolean :test
      t.references :order
      t.timestamps
    end
    add_index :order_transactions, :order_id
  end

  def self.down
    remove_index :order_transactions, :order_id
    drop_table :order_transactions
  end
end
