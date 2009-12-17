class ChangeOptimizedContentToFullTextOnSiteSetttings < ActiveRecord::Migration
  def self.up
    change_column :site_settings, :optimized_content, :text
  end

  def self.down
    change_column :site_settings, :optimized_content, :string
  end
end
