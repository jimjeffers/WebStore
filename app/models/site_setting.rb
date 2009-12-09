class SiteSetting < ActiveRecord::Base
  validates_presence_of :optimized_content
  validates_presence_of :seo_keywords
  validates_presence_of :products_per_page
  validates_presence_of :site_title
  validates_presence_of :seo_description
end
