require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Variation do
  before(:each) do
    @product = Factory.create(:product_shirt)
    @color = Factory.create(:color_red)
    @size = Factory.create(:garment_size)
    @variation = Factory.build(:variation, :product => @product, :color => @color, :garment_size => @size)
  end

  it "should create a new instance given valid attributes" do
    @variation.save.should be(true)
  end
  
  it "should be able to obtain it's garment size even if it's been deleted" do
    @variation.save
    @size.destroy
    retrieved = Variation.find(@variation.id)
    retrieved.garment_size.nil?.should be(false)
  end
  
  it "should be able to obtain it's color even if it's been deleted" do
    @variation.save
    @color.destroy
    retrieved = Variation.find(@variation.id)
    retrieved.color.nil?.should be(false)
  end
  
  it "should be able to obtain it's product even if it's been deleted" do
    @variation.save
    @product.destroy
    retrieved = Variation.find(@variation.id)
    retrieved.product.nil?.should be(false)
  end

end
