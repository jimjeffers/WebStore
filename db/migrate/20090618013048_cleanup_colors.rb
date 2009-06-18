class CleanupColors < ActiveRecord::Migration
  def self.up
    add_column :colors, :hex_value, :string
    remove_index :colors, :product_id
    remove_column :colors, :product_id
  end

  def self.down
    remove_column :colors, :hex_value
    add_column :colors, :product_id, :integer
    add_index :colors, :product_id
  end
end
