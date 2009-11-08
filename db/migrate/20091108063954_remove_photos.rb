class RemovePhotos < ActiveRecord::Migration
  def self.up
    remove_index :photos, :variation_id
    remove_index :photos, :parent_id
    remove_index :photos, :product_id
    drop_table :photos
  end

  def self.down
    create_table :photos do |t|
      t.column :parent_id,  :integer
      t.column :content_type, :string
      t.column :filename, :string    
      t.column :thumbnail, :string 
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
      t.datetime :deleted_at
      t.references :product
      t.references :variation
      t.timestamps
    end
    add_index :photos, :product_id
    add_index :photos, :parent_id
    add_index :photos, :variation_id
  end
end
