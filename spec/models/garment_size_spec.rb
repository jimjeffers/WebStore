require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GarmentSize do
  before(:each) do
    @garment_size = Factory.build(:garment_size)
  end

  it "should create a new instance given valid attributes" do
    @garment_size.save.should be(true)
  end
end
