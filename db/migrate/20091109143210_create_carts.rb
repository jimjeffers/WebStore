class CreateCarts < ActiveRecord::Migration
  def self.up
    create_table :carts do |t|
      t.references :user
      t.string :cart_token, :limit => 40
      t.string :aasm_state, :limit => 30, :default => 'new'
      t.timestamps
    end
  end

  def self.down
    drop_table :carts
  end
end
