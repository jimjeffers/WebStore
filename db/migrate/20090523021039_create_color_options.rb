class CreateColorOptions < ActiveRecord::Migration
  def self.up
    create_table :color_options do |t|
      t.references :product
      t.references :color
      t.timestamps
    end
    add_index :color_options, :product_id
    add_index :color_options, :color_id
  end

  def self.down
    remove_index :color_options, :color_id
    remove_index :color_options, :product_id
    mind
    drop_table :color_options
  end
end
