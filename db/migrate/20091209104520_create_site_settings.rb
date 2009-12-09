class CreateSiteSettings < ActiveRecord::Migration
  def self.up
    create_table :site_settings do |t|
      t.string :site_title
      t.string :seo_keywords
      t.string :seo_description
      t.string :optimized_content
      t.integer :products_per_page
      t.timestamps
    end
    SiteSetting.create( :site_title => "Cactus Sports",
                        :seo_keywords => "cactus sports, asu, sports apparel, clothing",
                        :seo_description => "Cactus Sports is ASU's own alumni powered sports shop!",
                        :optimized_content => "h2. Go Devils!
                        h3. Cactus Sports is ASU’s Independently Alumni Operated Sports Retailer!
                        Cactus Sports is Arizona State University independently owned and alumni operated 
                        and offers one of the largest selections of ASU merchandise from T-shirts, 
                        sweatshirts, shorts, hats, baby gear, gifts and much much more. Besides our 
                        great selection and quality products, we offer what most stores have 
                        forgotten, which is great customer service and a friendly and knowledgeable 
                        staff! For over 17 years Cactus Sports has been the place to shop for ASU 
                        students, faculty, and fans for the finest quality and best selection of 
                        Sun Devils gear. Cactus Sports is alumni and independently owned!",
                        :products_per_page => 28)
  end

  def self.down
    drop_table :site_settings
  end
end
