class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.references :variation
      t.references :cart
      t.integer :quantity
      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
