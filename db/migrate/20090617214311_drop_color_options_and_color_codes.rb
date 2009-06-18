class DropColorOptionsAndColorCodes < ActiveRecord::Migration
  def self.up
    remove_index :color_codes, :color_id
    drop_table :color_codes
    
    remove_index :color_options, :color_id
    remove_index :color_options, :product_id
    drop_table :color_options
  end

  def self.down
    create_table :color_codes do |t|
      t.string :name
      t.string :hex_value
      t.references :color
      t.timestamps
    end
    add_index :color_codes, :color_id

    create_table :color_options do |t|
      t.references :product
      t.references :color
      t.timestamps
    end
    add_index :color_options, :product_id
    add_index :color_options, :color_id
  end
end
