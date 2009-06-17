class CreateVariations < ActiveRecord::Migration
  def self.up
    create_table :variations do |t|
      t.references :product_id
      t.references :color_id
      t.references :garment_size_id
      t.string :sku
      t.timestamps
    end
  end

  def self.down
    drop_table :variations
  end
end
