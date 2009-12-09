class AddAasmToVariations < ActiveRecord::Migration
  def self.up
    add_column :variations, :aasm_state, :string, :default => "in_stock"
    add_index :variations, :aasm_state
  end

  def self.down
    remove_index :variations, :aasm_state
    remove_column :variations, :aasm_state
  end
end
