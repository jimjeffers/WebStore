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
  
  it "should not be able to retrieve a line item if it has been deleted and the line item is not closed." do
    @line_item.save
    @variation.destroy
    retreived = LineItem.find(@line_item.id)
    retreived.variation.nil?.should be(true)
  end
  
  it "should still be able to retrieve a line item if it has been deleted but the line item is closed." do
    @line_item.close!
    @variation.destroy
    retreived = LineItem.find(@line_item.id)
    retreived.variation.nil?.should be(false)
  end
end