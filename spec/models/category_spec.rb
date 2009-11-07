require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @category = Factory.build(:category)
  end

  it "should create a new instance given valid attributes" do
    @category.save.should be(true)
  end
end
