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

  describe 'add_category' do
    it "should fail if no" do
      
    end
  end
end
