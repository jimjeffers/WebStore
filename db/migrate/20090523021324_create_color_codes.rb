class CreateColorCodes < ActiveRecord::Migration
  def self.up
    create_table :color_codes do |t|
      t.string :name
      t.string :hex_value
      t.references :color
      t.timestamps
    end
    add_index :color_codes, :color_id
  end

  def self.down
    remove_index :color_codes, :color_id
    drop_table :color_codes
  end
end
