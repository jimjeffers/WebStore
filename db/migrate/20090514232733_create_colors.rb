class CreateColors < ActiveRecord::Migration
  def self.up
    create_table :colors do |t|
      t.string :name
      t.float :price
      t.string :sku, :length => 32
      t.references :product
      t.timestamps
    end
  end

  def self.down
    drop_table :colors
  end
end
