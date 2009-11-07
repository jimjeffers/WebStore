require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Color do
  before(:each) do
    @color = Factory.build(:color)
  end

  it "should create a new instance given valid attributes" do
    @color.save.should be(true)
  end
end
