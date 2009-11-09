require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Brand do
  before(:each) do
    @brand = Factory.build(:brand)
  end

  it "should create a new instance given valid attributes" do
    @brand.save.should be(true)
  end
end
