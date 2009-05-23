require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @valid_attributes = {
      :name => 'Test',
      :sku => 'CTC-TEST'
    }
  end

  it "should create a new instance given valid attributes" do
    Product.create!(@valid_attributes)
  end
  
  describe "potential_categories" do
    before(:each) do
      @category = Category.find_or_create_by_name('Category One')
      @category2 = Category.find_or_create_by_name('Category Two') 
      @product = Product.create!(@valid_attributes)
    end
    
    it "should return all categories if product currently belongs to none" do
      @product.potential_categories.length.should equal(2)
    end
    
    it "should return 1 category if product belongs to one" do
      @product.categories << @category
      @product.potential_categories.length.should equal(1)
    end
    
    it "should not include the category assigned to it" do
      @product.categories << @category2
      @product.potential_categories.include?(@category2).should be(false)
    end
    
    it "should include the category not assigned to it" do
      @product.categories << @category2
      @product.potential_categories.include?(@category).should be(true)
    end
  end

  describe 'add_category' do
    it "should fail if no" do
      
    end
  end
end
