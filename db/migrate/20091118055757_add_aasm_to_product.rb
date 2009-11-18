class AddAasmToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :aasm_state, :string, :default => "in_stock"
  end

  def self.down
    remove_column :products, :aasm_state
  end
end
