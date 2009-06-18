class CreateVariations < ActiveRecord::Migration
  def self.up
    create_table :variations do |t|
      t.references :product
      t.references :color
      t.references :garment_size
      t.string :sku
      t.timestamps
    end
    add_index :variations, :product_id
    add_index :variations, :color_id
    add_index :variations, :garment_size_id
  end

  def self.down
    remove_index :variations, :garment_size_id
    remove_index :variations, :color_id
    remove_index :variations, :product_id
    drop_table :variations
  end
end