class CreateBrands < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
      t.string :name
      t.string :logo_file_name,    :string
      t.string :logo_content_type, :string
      t.string :logo_file_size,    :integer
      t.string :logo_updated_at,   :datetime
      t.timestamps
    end
    add_column :products, :brand_id, :integer
  end

  def self.down
    remove_column :products, :brand_id
    drop_table :brands
  end
end
