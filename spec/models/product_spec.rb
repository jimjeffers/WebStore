require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @product = Factory.build(:product)
  end

  it "should create a new instance given valid attributes" do
    @product.save.should be(true)
  end
  
  describe "potential_categories" do
    before(:each) do
      @category_1 = Factory.create(:category)
      @category_2 = Factory.create(:category, :name => "Shorts")
    end
    
    it "should return all categories if product currently belongs to none" do
      @product.potential_categories.length.should equal(2)
    end
    
    it "should return 1 category if product belongs to one" do
      @product.categories << @category_1
      @product.potential_categories.length.should equal(1)
    end
    
    it "should not include the category assigned to it" do
      @product.categories << @category_2
      @product.potential_categories.include?(@category_2).should be(false)
    end
    
    it "should include the category not assigned to it" do
      @product.categories << @category_2
      @product.potential_categories.include?(@category_1).should be(true)
    end
  end
  
  describe 'all_with_gender' do
    before(:each) do
       @variation_1 = Factory(:shirt_girls_small_red)
       @variation_2 = Factory(:shorts_guys_large_blue)
       @variation_3 = Factory(:jacket_guys_medium_yellow)
    end
    
    it "should have a girls size small if it is a shirt according to the spec etc. etc..." do
      @variation_1.product.variations.first.garment_size.id.should be(@variation_1.garment_size.id)
      @variation_2.product.variations.first.garment_size.id.should be(@variation_2.garment_size.id)
      @variation_3.product.variations.first.garment_size.id.should be(@variation_3.garment_size.id)
    end
    
    it "should include the product referenced in variation 2 if we search for 'Guys'" do
      Product.all_with_gender('Guys').include?(@variation_2.product).should be(true)
    end
    
    it "should include the product referenced in variation 3 if we search for 'Guys'" do
      Product.all_with_gender('Guys').include?(@variation_3.product).should be(true)
    end
    
    it "should not include the product referenced in variation 1 if we search for 'Guys'" do
      Product.all_with_gender('Guys').include?(@variation_1.product).should be(false)
    end
    
    it "should include the product referenced in variation 1 if we search for 'Girls'" do
      Product.all_with_gender('Girls').include?(@variation_1.product).should be(true)
    end
  end
  
  describe 'add_category' do
    it "should be spec'd"
  end
  
  describe 'remove_category' do
    it "should be spec'd"
  end
end
