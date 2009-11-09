require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @category = Factory.build(:category)
  end

  it "should create a new instance given valid attributes" do
    @category.save.should be(true)
  end
  
  describe 'all_with_gender' do
    before(:each) do
      # TODO: Refactor the usage of factories in this before filter.
      # I know this is a bit ugly. Maybe there is a better way but heck.. 
      # the tests are really short.
       @category_1 = Factory(:category_shirts)
       @category_2 = Factory(:category_shorts)
       @product_1 = Factory(:product_shirt)
       @product_2 = Factory(:product_shorts)
       @product_3 = Factory(:product_jacket)
       @product_1.add_category(@category_1)
       @product_2.add_category(@category_2)
       @product_3.add_category(@category_1)
       @variation_1 = Factory(:shirt_girls_small_red, :product => @product_1)
       @variation_2 = Factory(:shorts_guys_large_blue, :product => @product_2)
       @variation_3 = Factory(:jacket_guys_medium_yellow, :product => @product_3)
    end
    
    it "should include the category for 'shirts' we search for 'Guys'" do
      Category.all_with_gender('Guys').include?(@category_1).should be(true)
    end
    
    it "should include the category for 'shorts' we search for 'Guys'" do
      Category.all_with_gender('Guys').include?(@category_1).should be(true)
    end
    
    it "should include the category for 'shirts' we search for 'Girls'" do
      Category.all_with_gender('Girls').include?(@category_1).should be(true)
    end
    
    it "should not include the category for 'shorts' we search for 'Girls'" do
      Category.all_with_gender('Girls').include?(@category_2).should be(false)
    end
  end
end
