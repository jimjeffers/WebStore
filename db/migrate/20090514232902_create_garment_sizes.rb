class CreateGarmentSizes < ActiveRecord::Migration
  def self.up
    create_table :garment_sizes do |t|
      t.string :name
      t.float :price
      t.string :sku, :length => 32
      t.references :color
      t.timestamps
    end
  end

  def self.down
    drop_table :garment_sizes
  end
end
