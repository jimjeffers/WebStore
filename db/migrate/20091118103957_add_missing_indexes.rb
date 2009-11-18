class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :line_items, :cart_id
    add_index :line_items, :variation_id
    add_index :orders, :cart_id
    add_index :products, :brand_id
    add_index :carts, :user_id
    add_index :products, :aasm_state
    add_index :line_items, :aasm_state
    add_index :orders, :aasm_state
    add_index :carts, :aasm_state
    add_index :variations, :deleted_at
    add_index :line_items, :deleted_at
    add_index :colors, :deleted_at
    add_index :garment_sizes, :deleted_at
    add_index :products, :deleted_at
  end
  
  def self.down
    remove_index :products, :deleted_at
    remove_index :garment_sizes, :deleted_at
    remove_index :colors, :deleted_at
    remove_index :line_items, :deleted_at
    remove_index :variations, :deleted_at
    remove_index :carts, :aasm_state
    remove_index :orders, :aasm_state
    remove_index :line_items, :aasm_state
    remove_index :products, :aasm_state
    remove_index :line_items, :cart_id
    remove_index :line_items, :variation_id
    remove_index :orders, :cart_id
    remove_index :products, :brand_id
    remove_index :carts, :user_id
  end
end