class CreateColors < ActiveRecord::Migration
  def self.up
    create_table :colors do |t|
      t.string :name
      t.references :product
      t.timestamps
    end
    add_index :colors, :product_id
  end

  def self.down
    #remove_index :colors, :product_id
    drop_table :colors
  end
end
