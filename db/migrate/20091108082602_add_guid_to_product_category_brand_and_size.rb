class AddGuidToProductCategoryBrandAndSize < ActiveRecord::Migration
  def self.up
    add_column :garment_sizes, :guid, :string
    add_column :products, :guid, :string
    add_column :categories, :guid, :string
    add_column :brands, :categories, :string
  end

  def self.down
    remove_column :brands, :categories
    remove_column :categories, :guid
    remove_column :products, :guid
    remove_column :garment_sizes, :guid
  end
end
