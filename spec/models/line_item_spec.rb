require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItem do
  before(:each) do
    @shirt = Factory.create(:product_shirt, :price => 10.99)
    @variation = Factory.create(:variation, :product => @shirt)
    @line_item = Factory.build(:line_item, :variation => @variation)
  end

  it "should create a new instance given valid attributes" do
    @line_item.save.should be(true)
  end
  
  it "should obtain the price of the product assigned to it's variation" do
    @line_item.save
    (@line_item.price == 10.99).should be(true) # Why does rspec make me do these things?
  end
end