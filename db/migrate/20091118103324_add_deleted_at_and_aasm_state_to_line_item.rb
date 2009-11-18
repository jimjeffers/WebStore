class AddDeletedAtAndAasmStateToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :deleted_at, :datetime
    add_column :line_items, :aasm_state, :string
  end

  def self.down
    remove_column :line_items, :aasm_state
    remove_column :line_items, :deleted_at
  end
end
