class AddSeoOptimizedContent < ActiveRecord::Migration
  def self.up
    add_column :products, :optimized_content, :text
    add_column :categories, :optimized_content, :text
  end

  def self.down
    remove_column :categories, :optimized_content
    remove_column :products, :optimized_content
  end
end
