class AddDeletedAtToProductsCategoriesAndVariations < ActiveRecord::Migration
  def self.up
    add_column :categories, :deleted_at, :datetime
    add_column :variations, :deleted_at, :datetime
    add_column :products, :deleted_at, :datetime
  end

  def self.down
    remove_column :products, :deleted_at
    remove_column :variations, :deleted_at
    remove_column :categories, :deleted_at
  end
end
