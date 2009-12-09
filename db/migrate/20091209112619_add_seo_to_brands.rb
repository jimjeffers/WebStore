class AddSeoToBrands < ActiveRecord::Migration
  def self.up
    add_column :brands, :title, :string
    add_column :brands, :seo_keywords, :string
    add_column :brands, :description, :string
    add_column :brands, :optimized_content, :text
  end
  def self.down
    remove_column :brands, :optimized_content
    remove_column :brands, :description
    remove_column :brands, :seo_keywords
    remove_column :brands, :title
  end
end
